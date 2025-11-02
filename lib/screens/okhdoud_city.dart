import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class OkhdoudCity extends StatefulWidget {
  const OkhdoudCity({super.key});

  @override
  State<OkhdoudCity> createState() => _OkhdoudCityState();
}

class _OkhdoudCityState extends State<OkhdoudCity>
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
      title: 'مدينة الأخدود الأثرية',
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
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/okhdoud_city.jpg',
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Texte et carousel
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'مدينة الأخدود الأثرية',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'تقع آثار الأخدود في قرية القابل على الضفة الجنوبية لوادي نجران من الناحية الجنوبية، وتعد من أهم المواقع الأثرية بمنطقة نجران، وهي المدينة التي ورد ذكرها في القرآن الكريم في سورة البروج: "قتل أصحاب الأخدود..." (الآيات 4-7).',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'يعد موقع الأخدود الأثري من أبرز المواقع الأثرية بالمنطقة، وهو الموقع الذي كانت تقوم عليه مدينة نجران القديمة، ويقع على الضفة الجنوبية لوادي نجران، بين قريتي القابل والجربة، والموقع يتمثل في مدينة مركزية يحيط بها سور بطول 235م، وعرض 220م، بنيت أساسات مبانيها من الأحجار المنحوتة بعناية بارتفاعات تتراوح بين 2-4 أمتار، وتمثل القلعة الفترة الرئيسية للاستيطان في الأخدود التي ربما بدأت قبل 600 ق.م، واستمرت حتى نهاية القرن الثالث الميلادي، وهي الفترة التي تتزامن مع ازدهار حضارة جنوب الجزيرة العربية، وفي خارج السور تنتشر تلال أثرية تحتوي على أساسات مبانٍ من الحجر والطين، وتنتشر عليها الكسر الفخارية بكثافة، وتمثل الفترة التالية لحضارة جنوب الجزيرة العربية، إلى جانب الفترة الإسلامية.',
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
