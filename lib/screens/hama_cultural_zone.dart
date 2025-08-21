import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class HamaCulturalZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'منطقة حمى الثقافية',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Partie haute avec image de fond et texte (25% de l'écran)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Coins arrondis
                child: Image.asset(
                  'assets/images/hama_cultural_zone.jpg',
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
                    'منطقة حمى الثقافية',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تعد منطقة حمى الثقافية من أبرز مواقع الرسوم والنقوش الصخرية، وتشمل: ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'الرسوم الآدمية والحيوانية, إلى جانب الكتابات بخط البادية المعروف بالثمودي والمسند الجنوبي والخط الكوفي , كما تحتوي هذه المنطقة على مواقع كثيرة تعود لمراحل حضارية مختلفة, وتمثل ركامات لمقابر وإنشاءات حجرية دائرية, وقد كان لأعمال المسح الأثري للنقوش في هذه المنطقة نتائج إيجابية حيث أمدتنا برسومات وفيرة عن المواقع التي تم توثيقها, التي احتوت على نقوش صخرية متعددة ومتنوعة, يمتد تاريخها من 7000 ق.م, إلى 1000 ق. م, ومن خلالها حصلنا على معلومات مهمة عن حياة الإنسان في تلك الفترة، فعلمنا مثلا أن سكان المنطقة آنذاك قد استأنسوا الكلاب السلوقية, واصطادوا الجمال والأبقار والماعز والنعام والخراف, مستخدمين أسلحة متنوعة منها الرماح, والعصي, والأقواس, والسهام ذات الرؤوس المزدوجة.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  CarouselExample(),
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
