import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class NajranPrinces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'أمراء منطقة نجران',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/najran_princes.jpg',
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
                    'الأمراء الذين تداولو على إمارة منطقة نجران:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "تعاقب على إمارة نجران 12 أميراً منذ العام 1352هـ على الترتيب التالي :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "1.صاحب السمو الأمير جلوي بن عبدالعزيز بن مساعد آل سعود أميراً لمنطقة نجران منذ عام 1436 هـ حتى الآن .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "2.صاحب السمو الملكي الأمير مشعل بن عبدالله بن عبدالعزيز آل سعود في عام 1430 هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "3.صاحب السمو الملكي الأمير مشعل بن سعود بن عبدالعزيز آل سعود في عام1417 هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "4.الأمير فهد بن خالد السديري في عام 1399هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "5.الأمير خالد بن أحمد السديري في عام 1383هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "6.الأمير إبراهيم النشمي (مرة أخرى) في عام 1374هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "7.الأمير علي آل مبارك في عام 1373هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "8.الأمير حمد بن محمد الماضي في عام 1370هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "9.الأمير تركي بن محمد الماضي في عام 1358هـ ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "10. الأمير عبدالعزيز الشقيحي في عام 1356هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "11. الأمير إبراهيم النشمي في عام 1355هـ .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "12. الأمير عساف بن حسين أول أمراء المنطقة في عام 1352هـ.",
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
