import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class PopularFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: ' الأكلات الشعبية',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Coins arrondis
                child: Image.asset(
                  'assets/images/popular_food.png',
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
                    ' الأكلات الشعبية:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'لأهالي منطقة نجران أكلات شعبية، منها ما تتشابه به مع المناطق الأخرى، ومنها ماهو خاص بالمنطقة حيث لا تزال الأسرة النجرانية متمسكة بعاداتها وتقاليدها الأصيلة، وسيرى الزائر للمنطقة عندما يحل ضيفا على أحد أبناء المنطقة ما تشتهيه الأنفس من تلك الأطعمة التراثية بما تحتويه من نكهة خاصة لا يعرفها إلا من تذوقها، ومنها:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '1.الوفد :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'وهو من البر (القمح) حيث يوضع بعض خبزه في إناء ثم يضغط بواسطة اليد حتى يصبح كالكرة، ثم يوضع في آنية من الخوص تسمى مطرح، ويقدم ومعه إناء به مرق، وهو شائع الانتشار في الكثير من المناسبات، وتسمى الأكلة بمجملها (وفد ومرق).',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '2.البر والسمن :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'يعمل البر كعملية الوفد ثم يوضع في إناء ،ويفتح في وسطه فتحة يصب فيها السمن، وأحيانا يضاف العسل وأحيانا «الرب» ويقدم كوجبة إفطار.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '3.الرقش  : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'وهو من البر يوضع خبزه في إناء ثم يصب فوقه المرق ويقدم، وهو من الأكلات المشهورة حتى وقتنا الحاضر.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '4.الحميسة :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'يقطع اللحم قطعا صغيرة ويطبخ، ثم يترك حتى يجف، ويضاف إليه الملح ثم يخزن، ويؤخذ منه كل وجبة قدر الحاجة، وفي وقتنا الحالي أصبح الاعتماد عليها أثناء عيد الأضحى المبارك ، بالإضافة إلى العديد من الأكلات الشعبية المنتشرة التي لازالت تتزين بها السفرة النجرانية، منها الفيد واللكية والربيكة والرب.',
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
