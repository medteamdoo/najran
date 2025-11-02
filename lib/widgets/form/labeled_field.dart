import 'package:flutter/material.dart';
import 'form_label.dart';

class LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool required;
  final int maxLines;
  final TextInputType type;
  final bool obscureText;
  final String? Function(String?)? validator;

  const LabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.required = false,
    this.maxLines = 1,
    this.type = TextInputType.text,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormLabel(text: label, required: required),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            keyboardType: type,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF9DA4AE),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Color(0xFF1B8354),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
            validator: (value) {
              // 1️⃣ Vérification du required
              if (required && (value == null || value.trim().isEmpty)) {
                return 'هذا الحقل مطلوب';
              }
              // 2️⃣ Vérification du validator passé en paramètre
              if (validator != null) {
                return validator!(value);
              }
              return null; // tout est ok
            },
          ),
        ],
      ),
    );
  }
}
