import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class Industry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'الصناعة في منطقة نجران',
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
                  'assets/images/industry.jpg',
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
                    'الصناعة في منطقة نجران',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'بلادنا تمتلك قدرات استثمارية ضخمة، وسنسعى إلى أن تكون محركاً لاقتصادنا ومورداً إضافياً لبلادنا " صاحب السمو الملكي ولي العهد الأمير محمد بن سلمان ن بن عبدالعزيز آل سعود وإنطلاقاً من هذه القناعة، وتماشياً مع مستهدفات الرؤية الطموحة للمملكة 2030 تشهد كافة مناطق المملكة نهضة تنموية شاملة في كافة القطاعات وعلى رأسها قطاع الصناعة.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ولأن نجران أرض التاريخ والإمكانات البشرية والثروات الكامنة والمتنوعة فتعد من المقاصد الاستثمارية الواعدة – بإذن الله – بما تمتلكه من مجالات ومقومات للاستثمار في المنطقة حيث تعتبر منطقة نجران من المناطق الحدودية المهمة للمملكة، وبها العديد من الجبال مثل جبال المسار، وجبال القهرة، وجبل خربان، وجبال الجوشن، وجبال بئر عسكر المشهورة بالجرانيت، كما يوجد بها العديد من الأودية مثل وادي نجران، ووادي حبونا، وادي الحبط، عشارة، صيحان، والسهول المنبسطة والكهوف والهضاب مثل هضبة نجران، والتجمعات الرملية.وتنقسم مصادر المياه في نجران إلى المياه الجوفية، والمياه السطحية، وعدد السدود بها يبلغ 18 سداً.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'كما تتوافر في منطقة نجران العديد من الخامات منها: كتل الجرانيت، ومواد كسارات البحص، والمعادن النفيسة والمعادن المصاحبة، النحاس والمعادن المصاحبة له، خام الحجر الجيري والطين والرمل.ويستحوذ خام كتل الجرانيت على النسبة الأكبر من الرخص الممنوحة في المنطقة بنسبة (73.5%)، بينما يستحوذ خام مواد كسارات البحص على النسبة الأكبر من الرخص الممنوحة على مستوى المملكة بشكل عام بنسبة (63.8%). ',
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
