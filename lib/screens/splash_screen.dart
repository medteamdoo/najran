import 'package:flutter/material.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OdooApiService _apiService = OdooApiService();

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() async {
    await _apiService.loadSession();

    final user = await _apiService.fetchCurrentUser();

    if (user != null) {
      CurrentUserHolder.instance.user = user;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // ❌ Session invalide ou expirée
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
