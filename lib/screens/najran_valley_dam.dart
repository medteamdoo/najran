import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class NajranValleyDam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: '  سد وادي نجران',
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
                  'assets/images/najran_valley_dam.png',
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
                    '  سد وادي نجران',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ويقف سد وادي نجران الذي يبعد عن المدينة بحوالي ٢٥ كلم كأهمية نموذجية للحفاظ على الثروة المستدامة في إدارة الموارد المائية، وتحسين الفرص الزراعية وجودة المياه، والحد من التصحر ، وتلبية جميع الاحتياجات في هذا المجال، بما يعزز النمو الاقتصادي ويحسن مستوى المعيشة للمنطقة.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ويتسع السد في طاقته القصوى إلى 86 مليون متر مكعب من المياه، في مساحة تصل إلى 5 كم2م ، ويتم تصريف المياه في السد عبر ثلاثة مخارج قريبة من قاعدته التي يبلغ قطر كل منها 2.25 متر تتحكم فيها بوابات انزلاقية في الواجهة السفلى للسد، بحيث تسمح هذه البوابات لبعض الترسبات المعلقة في بحيرة التخزين بالمرور من خلالها، وتم تشييد السد على شكل أسطواني ومقوس بنصف قطر (140) م وعرض (9.50) م وأقصى ارتفاع له من الأساسات إلى القمة (73) م وطول قمته (274) م، ويحتوي على (110.000) م 3 من الخرسانة ويمر من فوقه طريق على جسر عرضه (4.5).',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ويتم التحكم في درجة الحرارة الداخلية بضخ ماء مبرد من خلال نظام من الأنابيب قطر كل منها (25) مم مطموره في الخرسانة ولضمان تناسق وتواؤم جميع أجزاء البناء فان الفراغات بين الكتل تحقن بالضغط حتى يبرد جسم السد إلى درجة (22) درجة مئوية.وقد تم تزويد جسم السد وأكتافه بنظام متكامل للمراقبه لقياس الانجرافات الرأسية والأفقية للسد والأساسات بواسطة بندولات معلقه واكستنتامترات مثبته في وكذلك الضغوط الواقعة على السد من كل الاتجاهات إضافة إلى قياس درجة الحرارة في أجزاء مختلفه من جسم السد ويسجل مستوى الماء العلوي في البحيرة اتوماتيكيا وكذلك كمية المياه التي يتم تصريفها من الفتحات والمخارج لإعطاء صوره واضحه عن المياه التي بتم تصريفها من بحيرة السد بدقه.',
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
