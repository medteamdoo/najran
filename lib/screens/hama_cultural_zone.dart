import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/widgets/carousels/carousel.dart';

class HamaCulturalZone extends StatefulWidget {
  const HamaCulturalZone({super.key});

  @override
  State<HamaCulturalZone> createState() => _HamaCulturalZoneState();
}

class _HamaCulturalZoneState extends State<HamaCulturalZone>
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
      title: 'منطقة حمى الثقافية',
      currentIndex: 3,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/hama_cultural_zone.jpg',
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
                    children: const [
                      Text(
                        'منطقة حمى الثقافية',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'تعد منطقة حمى الثقافية من أبرز مواقع الرسوم والنقوش الصخرية، وتشمل:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'الرسوم الآدمية والحيوانية, إلى جانب الكتابات بخط البادية المعروف بالثمودي والمسند الجنوبي والخط الكوفي , كما تحتوي هذه المنطقة على مواقع كثيرة تعود لمراحل حضارية مختلفة, وتمثل ركامات لمقابر وإنشاءات حجرية دائرية, وقد كان لأعمال المسح الأثري للنقوش في هذه المنطقة نتائج إيجابية حيث أمدتنا برسومات وفيرة عن المواقع التي تم توثيقها, التي احتوت على نقوش صخرية متعددة ومتنوعة, يمتد تاريخها من 7000 ق.م, إلى 1000 ق. م, ومن خلالها حصلنا على معلومات مهمة عن حياة الإنسان في تلك الفترة، فعلمنا مثلا أن سكان المنطقة آنذاك قد استأنسوا الكلاب السلوقية, واصطادوا الجمال والأبقار والماعز والنعام والخراف, مستخدمين أسلحة متنوعة منها الرماح, والعصي, والأقواس, والسهام ذات الرؤوس المزدوجة.',
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
        ),
      ),
    );
  }
}
