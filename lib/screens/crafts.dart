import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class Crafts extends StatelessWidget {
  final List<Map<String, String>> items = [
    {"title": "البرمة", "desc": "قدر للطبح."},
    {"title": "التنور", "desc": "فرن للخبز."},
    {"title": "الزير", "desc": "وعاء لتبريد وحفظ الماء."},
    {"title": "الدهـن", "desc": "وعاء لتقديم الأكل."},
    {"title": "الجـمـنة", "desc": "وعاء لإعداد القهوة."},
  ];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'الحرف والأسوق الشعبية ',
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
                  'assets/images/crafts.jpg',
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
                    'الحرف التقليدية',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'الصناعات والحرفية التقليدية في نجران :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  Text(
                    'تمثل الحرف والصناعات الجانب المنتج من حياة المجتمع حيث تتداخل الحرف في مدلولها العام مع مفهوم الصناعات التقليدية, فإذا كان الرعي والصيد والزراعة والتجارة والتطبيب من الحرف فإن الحدادة والصناعة والحياكة والنجارة تمثل الصناعات.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ولاشك أن نجران من المناطق الغنية بتراثها الحضاري الذي ورثته عبر مختلف مراحلها التاريخية والحضارية, ويظهر ذلك بوضوح في تعدد الفنون الشعبية, والحرف, والمصنوعات التقليدية التي تعكس ذوقا فنيا, وتراثا غنيا.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'لقد تنوعت الصناعات والحرف في نجران, فشملت كل متطلبات الحياة اليومية، حيث تعددت أشكالها, وأحجامها, وألوانها, وموادها الخام حسب استخداماتها وأغراضها, ولعل تعدد وتنوع هذه الصناعات أدى إلى تنوع خصائصها الفنية التي عكست ذوق ومهارة الحرفيين, وتنوع ثقافاتهم, وأذواقهم.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'الصناعات الفخارية :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  Text(
                    ' تعد الصناعات الفخارية من أهم الصناعات قديما، ولا تزال تحظى بأهميتها حتى الآن, ودلت المعثورات من المواد الفخارية في نجران على أن هذه الصناعة كانت معروفة منذ الفترة السابقة لحضارة جنوب الجزيرة العربية حيث استمرت وتطورت مع مرور الوقت, واستفادت من التأثيرات الحضارية خلال فترة ازدهار عصر التجارة البرية في الجزيرة العربية مما أدى إلى تميزها, وبالرغم من أن صناعة الفخار في نجران خلال العصر الإسلامي المبكر جاءت انعكاسا للأنماط والسمات العامة لفخار حضارة جنوب الجزيرة العربية, وامتدادا لفخار الفترة البيزنطية فإنها أضافت طابعها المحلي الخاص الذي تمثل في ابتكار عناصر, وأنماط جديدة ميزتها عن غيرها.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'لقد شهدت صناعة الفخار في العصر الإسلامي تطورا كبيرا أثمر عن وجود أنماط جديدة, تميزت بزخارفها الإسلامية الجميلة, وألوانها المتعددة تمثلت في الأنماط السائدة للفخار خلال العصر الأموي والعباسي. وفي نجران تم العثور على كميات من الفخار الملون, المزجج, والخزف الذي يحمل سمات وخصائص الفخار خلال هذين العصرين, في حين لا تزال صناعة العديد من الأواني الفخارية في نجران رائجة حتى الوقت الحاضر ومنها:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      ...items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("• ", style: TextStyle(fontSize: 20)),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${item['title']}: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: item['desc'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'صناعة الحجر الصابوني :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  Text(
                    'تشير الدلائل الأثرية إلى أن الحجر الصابوني استخدم في صناعة الأواني منذ أواخر العصر الحجري الحديث. وفي موقع الأخدود الأثري تم العثور على كميات من هذا الحجر تنتمي إلى مختلف الفترات التاريخية والحضارية التي عاشتها المنطقة, وتمثل أجزاء من أبدان وحواف وقواعد لأوان مصنوعة من هذا الحجر الذي بتميز بقابليته للنحت والتشكيل, مكن الصانع من التميز في نحت وتزيين هذه الأواني بزخارف هندسية رائعة, وأمكن العثور على نماذج كثيرة لها في الأخدود, ولعل أهمية هذا الحجر استمرت حتى وقتنا الحاضر حيث لا تزال هذه الصناعة قائمة، ويعد المدهن من أهم مصنوعات الحجر الصابوني, ولا يزال يستخدم على نطاق واسع من قبل أهالي نجران حتى الآن.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '  الصناعات الخشبية :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  Text(
                    'يعد الخشب من أقدم وأكثر المواد التي استخدمها الإنسان حيث تم استخدامه منذ العصر الحجري عندما كانت الفؤوس, ورؤوس السهام الحجرية تثبت في مقابض خشبية, ومنذ ذلك الحين تعددت المصنوعات الخشبية خلال مختلف العصور فشملت الأبواب, والشبابيك, والأواني المنزلية, والأدوات الزراعية والصناعية, وغيرها, ولعل توافر الأخشاب في الطبيعة, وسهولة استخدامها ساعد على تنوع مصنوعاتها, واستعمالاتها, ولا يزال الكثير من هذه المصنوعات تستخدم في نجران حتى الآن ،وتشمل الأقداح, والمكاييل, والصحاف, والصناديق, والسرر, وغيرها, والتي يتم تزيين العديد منها بالزخارف الهندسية, والكتابات, والقطع المعدنية.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
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
