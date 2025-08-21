import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class DigitalVision extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'الرؤية والرسالة الرقمية',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/digital_vision.jpg',
                  height: screenHeight * 0.25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أمارة رقمية تسعى لزيادة رضا المستفيد:',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'الرسالة الرقمية :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'تمكين الأمارة رقمياً من خلال استخدام أفضل التقنيات الرقمية وأحدث الأنظمة المطورة لتلبية احتياجات الأعمال والخدمات وتطوير البنية التحتية التقنية اللازمة لزيادة رضا المستفيدين من خدمات الأمارة .',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
