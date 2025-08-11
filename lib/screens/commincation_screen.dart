import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class TawasolFormPage extends StatefulWidget {
  const TawasolFormPage({super.key});

  @override
  State<TawasolFormPage> createState() => _TawasolFormPageState();
}

class _TawasolFormPageState extends State<TawasolFormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: NajranScaffold(
        currentIndex: 0,
        title: 'تواصل معنا ',
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildLabeledField(
                  'اسمك *',
                  controller: nameController,
                  required: true,
                ),
                buildLabeledField('رقم الهوية', controller: idController),
                buildPhoneField(),
                buildLabeledField(
                  'العنوان *',
                  controller: addressController,
                  required: true,
                ),
                buildLabeledField(
                  'البريد الإلكتروني *',
                  controller: emailController,
                  required: true,
                  type: TextInputType.emailAddress,
                ),
                buildLabeledField(
                  'الموضوع *',
                  controller: subjectController,
                  required: true,
                ),
                buildLabeledField(
                  'الرسالة *',
                  controller: messageController,
                  required: true,
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Traitement d'envoi ici
                    }
                  },
                  child: const Text(
                    'إرسال',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const ContactInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabeledField(
    String label, {
    required TextEditingController controller,
    bool required = false,
    int maxLines = 1,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: type,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            validator: required
                ? (value) => value == null || value.trim().isEmpty
                      ? 'هذا الحقل مطلوب'
                      : null
                : null,
          ),
        ],
      ),
    );
  }

  Widget buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'رقم الهاتف الجوال',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Stack(
            children: [
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                left: 2,
                top: 2,
                bottom: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '966',
                    style: TextStyle(color: Color(0xFF6C737F), fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'التواصل',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            InfoRow(
              icon: Icons.location_on,
              text: 'طريق الملك عبد العزيز - 66251 - نجران',
            ),
            InfoRow(icon: Icons.phone, text: '(+966) 017-5220000'),
            InfoRow(icon: Icons.email, text: 'info@e-najran.gov.sa'),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
