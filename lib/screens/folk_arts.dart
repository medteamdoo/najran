import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class FolkArts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'الفنون الشعبية',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Coins arrondis
                child: Image.asset(
                  'assets/images/folk_arts.png',
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
                    'الفنون الشعبية:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    ' الفنون الشعبية تشتهر منطقة نجران بعدداً من الألوان الفلكلورية " الزامل، الرزفه، المثلوثه،الطبول، الشرح .',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  const Divider(height: 1),
                  SizedBox(height: 16),
                  Text(
                    '1.لون الزامل :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'الذي يعد من أهم الفنون الشعبية التي تؤدى في جميع مناسبات أهالي نجران ولا يقتصر أدائه على الأفراح بل يشمل ذلك مناسبات عديدة منها التوسط في حل الخلافات التي تنشأ بين القبائل أو الأفراد وما شابهها، حيث يُؤدى هذا اللون دون استخدام الإيقاعات حيث يصطف الأشخاص الذين يؤدونه بطريقة منتظمة وبلباس واحد وتكون كلماته في الغالب من بيتين من الشعر ، يردّدونه في لحن رجولي تمتلئ به الحناجر، مفسرين في معناها سبب قدومهم.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '2.لون الرزفة :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ويؤدى دون إيقاعات بواسطة مجموعة تنقسم إلى صفين يتناوبان على ترديد أبيات من الشعر، بينما يتحرك كل صف بشكل منظم كلاً في اتجاه الآخر تارة وإلى الخلف تارة أخرى يقوم بين تلك الصفين شخصين يوؤدون فن "السعب " .',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '3.لون فن المثلوثه : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'الذي يؤدى على شكل نصف دائرة بعدد من الرجال يرددون أبياتاٌ شعرية تتناول الأنماط الشعرية المعروفة بألحان عذبة ولها نظام معين في عدد الخطوات والإيقاع يتقدمهم يسمى " المزيف " الذي ينظم حركتهم وخطواتهم . ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '4.لون " الطبول " :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '​ ويعد من أكثر الألوان الشعبية في المنطقة ، ويجمع في مضامينه بين اللحن والإيقاع ويؤدى بواسطة صفين يقومون بأداء أسلوب الرزفة مع ترديد الأبيات الشعرية بألحان مختلفة وإيقاعات عديدة.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '5.لون الشرح :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    ' الشرح عند أهل شروره وشرقها وجنوبها ماخوذ من كلمة الانشراح اي انشراح النفس والصدر والشعور بالراحة النفسية والتعبير عن المشاعر الداخلية للمشارك في الشرح لانه فيه تروح للنفس وترويض للعقل وممارسة مهارات فنية تعبيرية من خلال الانسجام والتواصل اللفظي واللا لفظي بين المشاركين وأداءهم الفني والتفاعل الايجابي للتعبير عن شجونهم. والابيات الشعرية التي تقال في الشرح شعر غنائي له ألحان مختلفة حسب الوزن والكلمات ، التي تم القاءها من قبل أحد الشعراء ويحدث فيها سجل شعري غنائي من خلال الأداء الجميل للفرق الشعبية التي تؤدي الشرح ، وله ألحان متنوعة وجميلة . ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
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
