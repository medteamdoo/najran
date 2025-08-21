import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class KingFahdPark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'منتزه الملك فهد',
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
                  'assets/images/king_fahd_park.png',
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
                    'منتزه الملك فهد',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '  تبلغ المساحة الإجمالية لمنتزه الملك فهد 4254115 م2 ويوجد علية سور مسلح بطول 10165م/ط وكذلك يحتوي علي طرق معبدة وأرصفة داخل المنتزه بمساحة 319000 م2 ويوجد به مبنى لإدارة منتزه الملك فهد ومبني لضيافة زوار الأمانة والمنطقة، ويحتوي على مسطحات خضراء بمساحة 653575 م2 وأشجار وشجيرات عدد 31165 ونخيل عدد 850 و يوجد عدد 10 مباني لدورات المياه وعدد 1ملعب وعدد 1 مسرح روماني ويوجد ألعاب للأطفال والمتنزهين بعدد 59 لعبة واجهزة لياقة ويحتوي على عدد 1 نافورة، أعمدة انارة ديكوريه بعدد 637 عمود إنارة ديكوري وعدد 2 لوحة كهربائية وعدد 537 عمود انارة تابع للتشغيل والصيانة وعدد 6 لوحات كهربائية وعدد 6 محولات ، وممرات ومماشي للمتنزهين بين المسطحات بمساحة 125.914 م2 ، وعدد 195 حاوية نظافة وعدد 994 مصدات خرسانية وعدد 110 كراسي جلوس ، وفي خلال عام 2022م تم زراعة عدد 1930 شجرة وشجيرة ، وتم زراعة عدد 2100 شجرة وشجيرة خلال الربع الأول والثاني من عام 2023 م.',
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
