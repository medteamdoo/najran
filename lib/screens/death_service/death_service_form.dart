import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/widgets/form/labeled_field.dart';
import 'package:najran/widgets/form/phone_field.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class DeathServiceForm extends StatefulWidget {
  const DeathServiceForm({super.key});

  @override
  State<DeathServiceForm> createState() => _DeathServiceFormState();
}

class _DeathServiceFormState extends State<DeathServiceForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  String? _selectedFileName;

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

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: NajranScaffold(
        currentIndex: 0,
        title: "خدمة طلب ترحيل جثمان",
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabeledField(
                  label: 'إسم مقدم الطلب',
                  controller: nameController,
                  required: true,
                ),
                LabeledField(label: 'رقم الهوية', controller: idController),

                // ✅ File Picker
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: _pickFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          "اختر ملف",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedFileName ?? "لا يوجد ملف مختار",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),

                PhoneField(controller: phoneController),
                LabeledField(
                  label: 'العنوان',
                  controller: addressController,
                  required: true,
                ),
                LabeledField(
                  label: 'البريد الإلكتروني',
                  controller: emailController,
                  required: true,
                  type: TextInputType.emailAddress,
                ),
                LabeledField(
                  label: 'الموضوع',
                  controller: subjectController,
                  required: true,
                ),
                LabeledField(
                  label: 'الرسالة',
                  controller: messageController,
                  required: true,
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: envoyer les données + fichier au backend
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B8354),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
