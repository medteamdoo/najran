import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class Citrus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'الحمضيات في منطقة نجران',
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
                  'assets/images/citrus.jpg',
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
                    'الحمضيات في منطقة نجران',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تتمتع منطقة نجران بمقومات زراعية ومناخية ساهمت في إنتاج الحمضيات بأنواعها المختلفة لتشكل رافدا اقتصاديا وقيمة غذائية مهمة.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'وازدهرت زراعة الحمضيات عام 1982م بعد إنشاء مركز أبحاث البستنة في منطقة نجران ، الذي كان له دور بارز في نشر زراعة أشجار الحمضيات دائمة الاخضرار ذات الثمار الجيدة الحمراء والوردية والبرتقالية والصفراء الذهبية في مناطق المملكة ، ومنها منطقة نجران التي أصبحت إحدى مناطق زراعة الحمضيات ذات الجودة العالية في المملكة ، نظير ما تتمتع به المنطقة من أجواء مناخية معتدلة طوال أيام السنة ، وتربة خصبة ومياه عذبة بجودة عالية تتلاءم ونمط الري المناسب لزراعة الحمضيات .',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ويقوم المركز بإجراء البحوث والدراسات وتدريب الكوادر الوطنية والمزارعين وابنائهم , ونشر الوعي الزراعي السليم , ونشر زراعة الحمضيات في منطقة نجران وجميع مناطق المملكة التي تجود بها زراعة الحمضيات وتزويدهم بأصناف وأصول مدروسة مما كان له الأثر الكبير في ازدهار زراعة أشجار الحمضيات بالمنطقة مثل الليمون, البرتقال, اليوسفي بمختلف أنواعها , الكمكوات (ذو قشرة ناعمة وملساء ، ثمرته بيضاوية صغيرة ، برتقالية اللون ، تشبه ثمار البلح ، ينبت في عناقيد ،ينضج في أوقات مختلفة ، غالبا ما تكون أشجاره حاملة للزهر والثمر معظم أشهر السنة ، يؤكل بقشرته ),القريب فروت ، وتقدر المساحة الإجمالية المزروعة بالحمضيات في منطقة نجران بأكثر من ( 1005 ) هكتارات تنتج ما يقارب 25000 طن / سنويا ، وتبلغ أسعار كرتون الحمضيات الصغير من 25-35 ريال حسب النوع والحجم ، وذلك خلال موسم الإنتاج الذي يتوافق مع المهرجان السنوي للحمضيات من كل عام.',
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
