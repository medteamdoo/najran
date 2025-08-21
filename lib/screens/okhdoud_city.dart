import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class OkhdoudCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'مدينة الأخدود الأثرية',
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
                  'assets/images/okhdoud_city.jpg',
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
                    'مدينة الأخدود الأثرية',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تقع آثار الأخدود في قرية القابل على الضفة الجنوبية لوادي نجران من الناحية الجنوبية, وتعد من أهم المواقع الأثرية بمنطقة نجران, وهي المدينة التي ورد ذكرها في القران الكريم في سورة البروج قال تعالى: "قتل أصحاب الأخدود, النار ذات الوقود, إذ هم عليها قعود, وهم على ما يفعلون بالمؤمنين شهود".(الايات4-7).',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'يعد موقع الأخدود الأثري من أبرز المواقع الأثرية بالمنطقة, وهو الموقع الذي كانت تقوم عليه مدينة نجران القديمة, ويقع على الضفة الجنوبية لوادي نجران, بين قريتي القابل والجربة, والموقع يتمثل في مدينة مركزية يحيط بها سور بطول 235م, وعرض 220م, بنيت أساسات مبانيها من الأحجار المنحوتة بعناية بارتفاعات تتراوح بين 2-4 أمتار, وتمثل القلعة الفترة الرئيسية للاستيطان في الأخدود التي ربما بدأت قبل 600 ق.م , واستمرت حتى نهاية القرن الثالث الميلادي، وهي الفترة التي تتزامن مع ازدهار حضارة جنوب الجزيرة العربية, وفي خارج السور تنتشر تلال أثرية تحتوي على أساسات مبان من الحجر ومن الطين، وتنتشر عليها الكسر الفخارية بكثافة, وتمثل الفترة التالية لحضارة جنوب الجزيرة العربية, إلى جانب الفترة الإسلامية.',
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
