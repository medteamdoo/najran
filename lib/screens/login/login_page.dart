import 'package:flutter/material.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/widgets/form/labeled_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NajranLoginPage extends StatefulWidget {
  const NajranLoginPage({super.key});

  @override
  State<NajranLoginPage> createState() => _NajranLoginPageState();
}

class _NajranLoginPageState extends State<NajranLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final OdooApiService _apiService = OdooApiService();

  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);

    String? errorMessage = await _apiService.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (errorMessage == null) {
      final currentUser = await _apiService.fetchCurrentUser();
      if (currentUser != null) {
        CurrentUserHolder.instance.user = currentUser;
      }
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage, textDirection: TextDirection.rtl)),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  // --- Header ---
                  Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.17,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/saudia_flag.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.17,
                        width: double.infinity,
                        color: const Color(0xFF074D31).withOpacity(0.9),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/white_logo.png',
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // --- Body ---
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'مرحباً بك! الرجاء إدخال معلوماتك للدخول إلى حسابك بأمان.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          LabeledField(
                            label: 'إسم المستخدم',
                            controller: _usernameController,
                            required: true,
                          ),
                          const SizedBox(height: 12),
                          LabeledField(
                            label: 'كلمة المرور',
                            controller: _passwordController,
                            required: true,
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B8354),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                'تسجيل الدخول عبر نفاذ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- Footer ---
                  Container(
                    width: double.infinity,
                    height: 70,
                    color: const Color(0xFF074D31),
                    padding: const EdgeInsets.all(12.0),
                    child: const Center(
                      child: Text(
                        'جميع الحقوق محفوظة لهيئة الحكومة الرقمية © 2024',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Overlay de chargement ---
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
