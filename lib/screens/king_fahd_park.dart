import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class KingFahdPark extends StatefulWidget {
  const KingFahdPark({super.key});

  @override
  State<KingFahdPark> createState() => _KingFahdParkState();
}

class _KingFahdParkState extends State<KingFahdPark>
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
      title: 'منتزه الملك فهد',
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
                      'assets/images/king_fahd_park.png',
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
                        'منتزه الملك فهد',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'تبلغ المساحة الإجمالية لمنتزه الملك فهد 4,254,115 م² ويوجد عليه سور مسلح بطول 10,165 م، ويحتوي على طرق معبدة وأرصفة بمساحة 319,000 م²، ومبنى لإدارة المنتزه ومبنى ضيافة للزوار، بالإضافة إلى مسطحات خضراء بمساحة 653,575 م²، أشجار وشجيرات عدد 31,165، نخيل 850، 10 مباني لدورات المياه، 1 ملعب، 1 مسرح روماني، 59 لعبة وأجهزة لياقة للأطفال، 1 نافورة، أعمدة إنارة ديكورية 637، 2 لوحة كهربائية، 537 عمود إنارة للتشغيل والصيانة، 6 لوحات كهربائية، 6 محولات، ممرات بمساحة 125,914 م²، 195 حاوية نظافة، 994 مصد خرسانية، 110 كراسي جلوس، وزراعة 1,930 شجرة وشجيرة عام 2022، وزراعة 2,100 شجرة وشجيرة خلال النصف الأول من 2023.',
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
