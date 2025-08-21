import 'package:flutter/material.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/models/current_user_holder.dart';

class NajranLoginPage extends StatefulWidget {
  const NajranLoginPage({super.key});

  @override
  State<NajranLoginPage> createState() => _NajranLoginPageState();
}

class _NajranLoginPageState extends State<NajranLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final OdooApiService _apiService = OdooApiService();

  void _handleLogin() async {
    String? errorMessage = await _apiService.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (errorMessage == null) {
      // Récupération et stockage du user courant
      final currentUser = await _apiService.fetchCurrentUser();
      if (currentUser != null) {
        CurrentUserHolder.instance.user = currentUser;
      }
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Affichage du message d'erreur, y compris le cas du timeout en arabe
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage, textDirection: TextDirection.rtl)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', height: 100),
                  const SizedBox(height: 16),
                  const Text(
                    'إمارة منطقة نجران',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007E3D),
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'اسم المستخدم',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color(0xFF007E3D),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'كلمة المرور',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFF007E3D),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007E3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
