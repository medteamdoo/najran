import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class PrinceJalawiPark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'منتزه الأمير جلوي بن عبد العزيز',
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
                  'assets/images/prince_jalawi_park.png',
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
                    'منتزه الأمير جلوي بن عبد العزيز',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تبلغ المساحة الإجمالية لمنتزه الأمير جلوي 2180765 م2 ويوجد مبني لإدارة المنتزه، وكذلك يحتوي على طرق معبدة وأرصفة داخل المنتزه بمساحة 50400 م2 ويوجد مسطحات خضراء بمساحة 169121 م2 وأشجار وشجيرات ونخيل عدد 6500 شجرة وكذلك يوجد ممرات للمتنزهين بمساحة 141938 م2 ويحتوي على عدد 3 مباني لدورات المياه وألعاب للأطفال والمتنزهين بعدد 25 لعبة، وعدد 2 ملعب ،وأعمدة انارة ديكوريه بعدد 836 عمود وعدد 86 كرسي جلوس وعدد 252 حاوية نظافة وعدد 317 مصدات خرسانية، وفي خلال عام 2022م تم زراعة عدد 771 شجرة وشجيرة ، وتم زراعة عدد 1584 شجرة وشجيرة خلال الربع الأول والثاني من عام 2023 م.',
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
