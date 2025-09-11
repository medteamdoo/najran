import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String text;
  final bool required;

  const FormLabel({super.key, required this.text, this.required = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (required)
            const TextSpan(
              text: '* ',
              style: TextStyle(
                color: Color(0xFFB42318),
                fontWeight: FontWeight.bold,
              ),
            ),
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
