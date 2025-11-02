import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class PrinceJalawiPark extends StatefulWidget {
  const PrinceJalawiPark({super.key});

  @override
  State<PrinceJalawiPark> createState() => _PrinceJalawiParkState();
}

class _PrinceJalawiParkState extends State<PrinceJalawiPark>
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
      title: 'منتزه الأمير جلوي بن عبد العزيز',
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
                      'assets/images/prince_jalawi_park.png',
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
                        'منتزه الأمير جلوي بن عبد العزيز',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'تبلغ المساحة الإجمالية لمنتزه الأمير جلوي 2,180,765 م² ويوجد مبنى لإدارة المنتزه، وطرق معبدة وأرصفة بمساحة 50,400 م²، ومساطح خضراء بمساحة 169,121 م²، أشجار وشجيرات ونخيل عدد 6,500، ممرات بمساحة 141,938 م²، 3 مباني لدورات المياه، 25 لعبة للأطفال، 2 ملعب، أعمدة إنارة ديكورية 836، 86 كرسي جلوس، 252 حاوية نظافة، 317 مصدات خرسانية، وزراعة 771 شجرة وشجيرة عام 2022، وزراعة 1,584 شجرة وشجيرة في النصف الأول من 2023.',
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
