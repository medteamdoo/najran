import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class HistoricalImaraCastle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'قصر الامارة التاريخي',
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
                  'assets/images/historical_imara_castle.jpg',
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
                    'قصر الامارة التاريخي',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'يحتضن حي أبا السعود (البلد) بمدينة نجران رمزاً وطنياً تراثياً مهماً لا تُغفله عين زائر المكان، فبمجرد الوصول للسوق التراثي القديم يتجسد للمشاهد قصر الإمارة التاريخي في كامل حلته وشموخه، وكدلالة وطنية لتاريخ حي نابض متصل بحضارة مستدامة تهب تناغماً بصرياً مريحاً يضفي جودة للحياة، ويتكامل مشهد الصورة ليشكل فكرة عن نموذج النسيج العمراني لبيت الطين بنجران، واطاراً ثقافياً مُلهماً للزوار والسواح.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'قصر الإمارة التاريخي بنجران وهو شاهد المدينة وعنوانها ومصدر ثقتها الذي يعبر عن ثقافتها الوطنية وقدرتها الإبداعية البشرية، وهو ذاك الجسر المتين للتواصل بين الأجيال وتكوين شخصية تتبلور من مفاهيم الهوية الوطنية.ويقع القصر الذي تم الانتهاء من أعمال البناء عام 1363هـ واستغرق بناؤه ما يقارب سنتين على مساحة إجمالية قدرها 6252 مترًا مربعًا، ويتكون من ثلاث طوابق وتم إنشاؤه كمقر لإمارة منطقة نجران والإدارات الحكومية آنذاك كما يضم القصر مجلس الأمير الذي خصص لاستقبال الضيوف والمناسبات الرسمية، وغرفة الطعام، وغرفة إعداد القهوة، وغرفة كمخزن، كما اشتمل القصر على سبعة عشر غرفة تشتمل على غرف سكنية، وغرف لمستودع الأطعمة، والأدوات بالإضافة إلى أربع غرف لمستودعات المواشي، كما يحوي القصر اثنتي عشرة غرفة أخرى.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'وتقع في فناء القصر من الجهة الشرقية بئرٌ قديمة ترجع إلى عصر ما قبل الإسلام بُني الجزء السفلي منها بواسطة اللبن المحروق، ويعتلي سور القصر المرتفع أربعة أبراج دائرية على أركانه الأربعة تتميز بشكل دائري تسمى القصبات كانت تستخدم لحراسة القصر آنذاك.ويلاقي قصر الإمارة التاريخي اهتماماً متزايداً من الزوار والسواح لما له من قيمة تاريخية كبيرة وقيمة تراثية ثقافية، كما يمتاز موقعه بمنطقة ذات جذب سياحي تتواجد فيها الأسواق الشعبية كسوق الجنابي والصناعات الجلدية التراثية ومحال بيع الفخاريات وخياطة وبيع الثياب التراثية النجرانية للرجال والنساء.',
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
