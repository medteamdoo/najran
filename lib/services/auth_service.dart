import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:najran/config/config.dart';
import 'package:najran/models/user.dart';
import 'package:najran/models/current_user_holder.dart';

class OdooApiService {
  final _storage = const FlutterSecureStorage();
  final String baseUrl = AppConfig.baseUrl;
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  /// Authentifie l'utilisateur
  Future<String?> login(String login, String password) async {
    final url = Uri.parse('$baseUrl/auth/');

    try {
      final response = await http
          .post(
            url,
            headers: headers,
            body: jsonEncode({"login": login, "password": password}),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('مشكلة في الاتصال'),
          );

      final setCookie = response.headers['set-cookie'];
      if (setCookie != null) {
        final sessionMatch = RegExp(
          r'session_id=([^;]+)',
        ).firstMatch(setCookie);
        if (sessionMatch != null) {
          final sessionId = sessionMatch.group(1);
          final cookieString = "session_id=$sessionId";

          await _storage.write(key: 'session_cookie', value: cookieString);
          headers['Cookie'] = cookieString;
        }
      }

      final data = jsonDecode(response.body);

      if (data is Map && data.containsKey('error')) {
        final message = data['error']?['data']?['message'] ?? 'Erreur inconnue';
        print('❌ Échec de connexion : $message');
        return message;
      }

      if (data is Map && data.containsKey('result')) {
        print('✅ Connexion réussie pour ${data["result"]["username"]}');
        return null;
      }

      print('⚠️ Réponse inattendue : ${response.body}');
      return 'Réponse inattendue du serveur';
    } catch (e) {
      print('⚠️ Erreur login : $e');
      return e.toString().contains('مشكلة')
          ? 'مشكلة في الاتصال'
          : 'Erreur lors de la connexion';
    }
  }

  Future<String?> fetchGuideId(String? serviceType) async {
    try {
      final response = await getModelData(
        model: "guide/$serviceType",
        query: "{}",
      );
      final result = response['result'];
      final guideId = result['guide_id'];
      if (guideId != null && guideId != false) {
        return guideId.toString();
      }
      return null;
    } catch (e) {
      print("⚠️ Erreur fetchGuideId: $e");
      return null;
    }
  }

  /// Charge le cookie depuis le stockage
  Future<void> loadSession() async {
    final storedCookie = await _storage.read(key: 'session_cookie');
    if (storedCookie != null) {
      headers['Cookie'] = storedCookie;
    }
  }

  Future<User?> fetchCurrentUser() async {
    try {
      final sessionCookie = await _storage.read(key: 'session_cookie');
      if (sessionCookie == null) {
        print('⚠️ Session invalide : cookie non trouvé');
        await logout();
        return null;
      }

      final url = Uri.parse('$baseUrl/api/current_user');
      final requestHeaders = {
        'Content-Type': 'application/json',
        'Cookie': sessionCookie,
      };

      print('🔗 Requête POST vers: ${url.toString()}');

      final response = await http
          .post(
            url,
            headers: requestHeaders,
            body: jsonEncode({
              "query":
                  "{id, name, email, login, image_1920, phone, company_id{name}, commercial_company_name, identity_number}",
            }),
          )
          .timeout(const Duration(seconds: 10));

      print('⚡ Réponse: ${response.statusCode}');
      print('📦 Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      // Vérification de la structure JSON-RPC
      if (responseData is! Map<String, dynamic> ||
          responseData['jsonrpc'] != '2.0') {
        throw FormatException('Réponse API invalide');
      }

      switch (response.statusCode) {
        case 200:
          // Extraction du résultat depuis la réponse JSON-RPC
          final result = responseData['result'] as Map<String, dynamic>;
          return User.fromJson(result);
        case 401:
          print('🔐 Session expirée');
          await logout();
          return null;
        default:
          // Gestion des erreurs JSON-RPC
          final error = responseData['error'] as Map<String, dynamic>?;
          print('❌ Erreur API: ${error?['message'] ?? response.body}');
          return null;
      }
    } on SocketException {
      print('🌐 Erreur réseau');
      return null;
    } on TimeoutException {
      print('⏱️ Timeout');
      return null;
    } on FormatException catch (e) {
      print('📄 Format de réponse invalide: $e');
      return null;
    } catch (e) {
      print('‼️ Erreur inattendue: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> getModelData({
    required String model,
    String? query,
    List? filter,
    String? order,
    int? page,
    int? pageSize,
    int? limit,
    String? name,
    Map<String, dynamic>? context,
  }) async {
    final sessionCookie = await _storage.read(key: 'session_cookie');
    if (sessionCookie == null) {
      print('❌ Session invalide : cookie non trouvé');
      await logout();
    }
    final url = Uri.parse("$baseUrl/$model");

    final body = {
      "query": query,
      if (filter != null) "filter": jsonEncode(filter),
      if (order != null) "order": order,
      if (name != null) "name": name,
      if (page != null) "page": page,
      if (pageSize != null) "page_size": pageSize,
      if (limit != null) "limit": limit,
      if (context != null) "context": jsonEncode(context),
    };

    final response = await http.post(
      url,
      headers: {...headers, 'Cookie': ?sessionCookie},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur Odoo: ${response.statusCode} ${response.body}');
    }
  }

  Future<bool> sendFormulaire({
    required BuildContext context, // 👈 on ajoute ça
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final sessionCookie = await _storage.read(key: 'session_cookie');
      if (sessionCookie == null) {
        print('⚠️ Session cookie non trouvé, envoi quand même...');
      }

      final url = Uri.parse('$baseUrl/$endpoint');
      final requestHeaders = {...headers};

      if (sessionCookie != null) {
        requestHeaders['Cookie'] = sessionCookie;
      }

      print("📤 Envoi formulaire à $url avec data: $data");

      final response = await http
          .post(url, headers: requestHeaders, body: jsonEncode(data))
          .timeout(const Duration(seconds: 20));

      print("⚡ Réponse formulaire: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      Map<String, dynamic>? res;
      try {
        res = jsonDecode(response.body);
      } catch (_) {
        print("⚠️ Impossible de parser la réponse en JSON");
      }

      if (response.statusCode == 200) {
        if (res != null && res['result'] is Map) {
          final result = res['result'];
          if (result['success'] == true) {
            print("✅ Formulaire envoyé avec succès: ${result['message']}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  result['message'] ?? 'Formulaire envoyé avec succès',
                ),
                backgroundColor: Colors.green,
              ),
            );
            return true;
          } else {
            final errorMessage =
                result['error'] ?? result['message'] ?? 'Erreur inconnue';
            print("❌ Erreur côté Odoo: $errorMessage");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
            return false;
          }
        } else {
          print("❌ Réponse inattendue: $res");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Réponse inattendue du serveur."),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
      } else {
        // 🟥 Cas où le code HTTP != 200
        String errorMessage = "Erreur HTTP ${response.statusCode}";
        if (res != null && res.containsKey('error')) {
          errorMessage = res['error'].toString();
        } else if (response.reasonPhrase != null) {
          errorMessage = "${response.reasonPhrase}";
        }

        print("❌ $errorMessage");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
        return false;
      }
    } catch (e) {
      print("⚠️ Erreur sendFormulaire: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: $e"), backgroundColor: Colors.red),
      );
      return false;
    }
  }

  /// Déconnexion
  Future<void> logout() async {
    headers.remove('Cookie');
    await _storage.delete(key: 'session_cookie');
    CurrentUserHolder.instance.user = null;
  }
}
