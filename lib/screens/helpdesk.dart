import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/cards/contact_info_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/widgets/form/labeled_field.dart';
import 'package:najran/widgets/form/phone_field.dart';

class helpDeskFormPage extends StatefulWidget {
  const helpDeskFormPage({super.key});

  @override
  State<helpDeskFormPage> createState() => helpDeskFormPageState();
}

class helpDeskFormPageState extends State<helpDeskFormPage> {
  final OdooApiService _apiService = OdooApiService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final urlController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  String? siteProblem;

  @override
  void initState() {
    super.initState();
    final currentUser = CurrentUserHolder.instance.user;
    if (currentUser != null) {
      nameController.text = currentUser.name;
      emailController.text = currentUser.email;
      phoneController.text = currentUser.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: NajranScaffold(
        currentIndex: 0,
        title: 'بلاغ فني',
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LabeledField(
                      label: 'اسمك',
                      controller: nameController,
                      required: true,
                    ),
                    LabeledField(
                      label: 'البريد الإلكتروني',
                      controller: emailController,
                      required: true,
                      type: TextInputType.emailAddress,
                    ),
                    LabeledField(
                      label: 'رابط الصفحة',
                      controller: urlController,
                      required: true,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "هل واجهتك مشكلة في الموقع؟",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    RadioListTile<String>(
                      title: const Text("نعم"),
                      value: "oui",
                      groupValue: siteProblem,
                      onChanged: (value) {
                        setState(() {
                          siteProblem = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("لا"),
                      value: "non",
                      groupValue: siteProblem,
                      onChanged: (value) {
                        setState(() {
                          siteProblem = value;
                        });
                      },
                    ),

                    LabeledField(
                      label: 'نص البلاغ',
                      controller: messageController,
                      required: true,
                      maxLines: 4,
                    ),
                    PhoneField(controller: phoneController),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (siteProblem == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("الرجاء اختيار نعم أو لا"),
                                  ),
                                );
                                return;
                              }

                              setState(() => _isLoading = true);

                              final name = nameController.text.trim();
                              final email = emailController.text.trim();
                              final phone = phoneController.text.trim();
                              final description = messageController.text.trim();
                              final url = urlController.text.trim();

                              try {
                                final success = await _apiService
                                    .sendFormulaire(
                                      endpoint:
                                          "/mobile/beneficiary/helpdesk/submit",
                                      data: {
                                        "اسمك": name,
                                        "email_from": email,
                                        "الجوال": phone,
                                        "نص البلاغ": description,
                                        "رابط الصفحة": url,
                                        "هل واجهتك مشكلة في الموقع؟":
                                            siteProblem,
                                      },
                                    );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? "تم إرسال النموذج بنجاح"
                                          : "حدث خطأ أثناء الإرسال",
                                    ),
                                  ),
                                );

                                if (success) {
                                  _formKey.currentState!.reset();
                                  setState(() => siteProblem = null);
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("خطأ: $e")),
                                );
                              } finally {
                                setState(() => _isLoading = false);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B8354),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            "إرسال",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const ContactInfoCard(),
                  ],
                ),
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
