import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class FolkArts extends StatefulWidget {
  @override
  _FolkArtsState createState() => _FolkArtsState();
}

class _FolkArtsState extends State<FolkArts>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

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
      title: 'الفنون الشعبية',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/folk_arts.png',
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
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
                    'الفنون الشعبية تشتهر منطقة نجران بعدداً من الألوان الفلكلورية " الزامل، الرزفه، المثلوثه،الطبول، الشرح .',
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
                    'الذي يعد من أهم الفنون الشعبية التي تؤدى في جميع مناسبات أهالي نجران ...',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '2.لون الرزفة :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ويؤدى دون إيقاعات بواسطة مجموعة تنقسم إلى صفين ...',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '3.لون فن المثلوثه :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'الذي يؤدى على شكل نصف دائرة بعدد من الرجال ...',
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
                    'ويعد من أكثر الألوان الشعبية في المنطقة ...',
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
                    'الشرح عند أهل شروره وشرقها وجنوبها ماخوذ من كلمة الانشراح ...',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  CarouselExample(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
