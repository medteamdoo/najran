import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class RegionInfoScreen extends StatefulWidget {
  const RegionInfoScreen({super.key});

  @override
  State<RegionInfoScreen> createState() => _RegionInfoScreenState();
}

class _RegionInfoScreenState extends State<RegionInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'منطقة نجران',
      currentIndex: 3,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image d'en-tête
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/najran.jpg',
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Texte principal
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'نبذة عن منطقة نجران',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'حبا الله سبحانه وتعالى منطقة نجران الواقعة في الجنوب الغربي من المملكة العربية السعودية بمقومات سياحية متميزة وموقع استراتيجي كواجهة على طرق الصحراء ومناخ معتدل صيفا وشتاء، ومنطقة نجران التي تعد رابع منطقة سعودية من حيث المساحة ( 360 ألف كلم مربع ) تشتمل على ثلاث بيئات جغرافية: منطقة سهلية خصبة تقع في وسط نجران وتمثل الثقل التاريخي والبشري وتضم العديد من الأودية وأشهرها وادي نجران، منطقة جبلية في الغرب والشمال تضم العديد من المنتزهات الجميلة وأشجار السدر والآثار التاريخية العريقة، ومنطقة رملية في الشرق وهي جزء من صحراء الربع الخالي.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'الموقع:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'تقع منطقة نجران في الجنوب الغربي من المملكة العربية السعودية بين خطي عرض 17 و 20 درجة شمالا وخطي طول 52 و 44 درجة شرقا، ويحدها من الشرق صحراء الربع الخالي ومن الغرب منطقة عسير ومن الشمال منطقة الرياض ومن الجنوب اليمن، ويتبع لها ست محافظات هي: شروره، حبونا، ثار، يدمه، بدر الجنوب، خباش.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'عدد السكان:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'يقدر عدد سكان منطقة نجران حوالي 592.300 نسمة، وقد حصلت المنطقة على نصيب من التطور في جميع المجالات كالعمرانية والزراعة والخدمات.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'المناخ:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'تمتاز نجران بمناخ معتدل شتاءً، شديد البرودة في المناطق الجبلية، ومعتدل الحرارة صيفًا، أما الأمطار فهي متوسطة شتاءً وغزيرة صيفًا.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'حضارات المنطقة:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '1. المرحلة الأولى: بدأت قبل أكثر من 1.5 مليون سنة، واستمرت حتى حوالي 2000ق.م، تعرف بحضارة العصر الحجري.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '2. المرحلة الثانية: بدأت قبل سنة 1000ق.م، وشهدت نشأة مدينة نجران القديمة وازدهار التجارة البرية.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '3. المرحلة الثالثة: بدأت بحلول عام 300ق.م وانتهت بحلول فجر الإسلام، تمثلت في شمال شرق الموقع.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '4. المرحلة الرابعة: المرحلة الإسلامية والتي بدأت في السنة التاسعة والعاشرة للهجرة.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'الأهمية الاقتصادية قديماً:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'احتلت نجران قديما موقعاً هاماً من الناحية الاقتصادية، وكانت مركزاً للتجارة القديمة، واشتهرت بسلعها الجيدة مثل اللبان والمر والبخور.',
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
        ),
      ),
    );
  }
}
