import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFf9fafb),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFD2D6DB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'التواصل',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: "assets/icons/localisation_2.svg",
              title: "الموقع",
              value: "طريق الملك عبد العزيز - 66251 - نجران",
              trailingIcon: "assets/icons/chain.svg",
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: "assets/icons/phone.svg",
              title: "الهاتف",
              value: "(+966) 017-5220000",
              trailingIcon: "assets/icons/share.svg",
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: "assets/icons/mail_2.svg",
              title: "البريد الالكتروني",
              value: "info@e-najran.gov.sa",
              trailingIcon: "assets/icons/share.svg",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String icon,
    required String title,
    required String value,
    String? trailingIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(icon, width: 20, height: 20),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const SizedBox(width: 20),
            Text(
              value,
              style: const TextStyle(color: Color(0xFF1B8354), fontSize: 16),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 5),
              SvgPicture.asset(trailingIcon, width: 20, height: 20),
            ],
          ],
        ),
      ],
    );
  }
}
