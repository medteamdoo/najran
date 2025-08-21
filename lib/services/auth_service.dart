import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
              "query": "{id, name, email, login, image_1920, company_id{name}}",
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
    required String query,
    List? filter,
    String? order,
    int? page,
    int? pageSize,
    int? limit,
    Map<String, dynamic>? context,
  }) async {
    final sessionCookie = await _storage.read(key: 'session_cookie');
    if (sessionCookie == null) {
      print('❌ Session invalide : cookie non trouvé');
      await logout();
    }
    final url = Uri.parse("$baseUrl/get/$model");

    final body = {
      "query": query,
      if (filter != null) "filter": jsonEncode(filter),
      if (order != null) "order": order,
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

  /// Déconnexion
  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/logout');

    try {
      await http.post(url, headers: headers);
    } catch (e) {
      print('⚠️ Erreur appel /logout : $e');
    }

    headers.remove('Cookie');
    await _storage.delete(key: 'session_cookie');
    CurrentUserHolder.instance.user = null;
  }
}
