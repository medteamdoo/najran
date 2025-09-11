import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/cards/contact_info_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/widgets/form/labeled_field.dart';
import 'package:najran/widgets/form/phone_field.dart';

class SuggestionFormPage extends StatefulWidget {
  const SuggestionFormPage({super.key});

  @override
  State<SuggestionFormPage> createState() => SuggestionFormPageState();
}

class SuggestionFormPageState extends State<SuggestionFormPage> {
  final OdooApiService _apiService = OdooApiService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final identityController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final choiceController = TextEditingController();
  final reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentUser = CurrentUserHolder.instance.user;
    if (currentUser != null) {
      nameController.text = currentUser.name;
      emailController.text = currentUser.email;
      phoneController.text = currentUser.phone;
      identityController.text = currentUser.identityNumber ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: NajranScaffold(
        currentIndex: 0,
        title: 'مقترحات المواطنين',
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
                      label: 'رقم الهوية',
                      controller: identityController,
                      required: true,
                    ),
                    LabeledField(
                      label: 'البريد الإلكتروني',
                      controller: emailController,
                      required: true,
                      type: TextInputType.emailAddress,
                    ),
                    LabeledField(
                      label: 'العنوان',
                      controller: addressController,
                      required: true,
                    ),
                    LabeledField(
                      label: 'اختر جهة الاقتراح',
                      controller: choiceController,
                    ),
                    LabeledField(
                      label: 'الموضوع',
                      controller: subjectController,
                      required: true,
                    ),
                    LabeledField(
                      label: 'نص الاقتراح',
                      controller: messageController,
                      required: true,
                      maxLines: 4,
                    ),
                    LabeledField(
                      label: 'سبب الاقتراح',
                      controller: reasonController,
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
                              setState(() => _isLoading = true);

                              final name = nameController.text.trim();
                              final email = emailController.text.trim();
                              final phone = phoneController.text.trim();
                              final identity = identityController.text.trim();
                              final address = addressController.text.trim();
                              final subject = subjectController.text.trim();
                              final description = messageController.text.trim();
                              final reason = reasonController.text.trim();
                              final choice = choiceController.text.trim();

                              try {
                                final success = await _apiService.sendFormulaire(
                                  endpoint:
                                      "/mobile/beneficiary/suggestion/submit",
                                  data: {
                                    "الاسم الرباعي": name,
                                    "email_from": email,
                                    "الجوال": phone,
                                    "رقم الهوية": identity,
                                    "العنوان": address,
                                    "subject": subject,
                                    "نص الاقتراح": description,
                                    "اختر جهة الاقتراح": choice,
                                    "سبب الاقتراح": reason,
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

                                if (success) _formKey.currentState!.reset();
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
