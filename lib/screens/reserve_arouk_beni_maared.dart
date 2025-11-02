import 'package:flutter/material.dart';
import 'package:najran/widgets/carousels/carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class ReserveAroukBeniMaared extends StatefulWidget {
  const ReserveAroukBeniMaared({super.key});

  @override
  State<ReserveAroukBeniMaared> createState() => _ReserveAroukBeniMaaredState();
}

class _ReserveAroukBeniMaaredState extends State<ReserveAroukBeniMaared>
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
      title: 'محمية عروق بني معارض',
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
                      'assets/images/reserve_arouk_beni_maared.jpg',
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
                        'محمية عروق بني معارض',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'تقع محميّة عروق بني معارض على الحافة الجنوبية الغربيّة للرّبع الخالي؛ وتبلغ مساحتها 12787 كيلومتراً مربّعا. وتضمّ المحميّة عددا من التّشكيلات الأرضية والمواطن الفطريّة الطّبيعيّة الهامة منها كثبان رمليّة مرتفعة وهضبة جيريّة متقطّعة. تعتبر الحالة البيئية للمحميّة بصورة عامة جيدة والحياة الفطريّة النباتية والحيوانية فيها ممثلة للبيئات القاحلة. ومن أكثر النباتات شيوعا فيها الغضى والأثموم وأشجار الطلح والبان والحرمل والطّرف والعشر. ومن أهم الحيوانات الموجودة في المحميّة الذّئب والقطّ الرّملي والثعلب الرّملي والضبع المخطط والوبر والأرنب البري، ومن الطّيور الحبارى والقطا والحجل والصّرد الرّمادي والرّخمة المصريّة وعدة أنواع من القنابر وأنواع عديدة من الزّواحف منها الضّب والورل.',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'وتعتبر المحميّة آخر المواطن في الجـزيرة العربيـة التّي شوهد فيها المها العربي عام 1979م. كما أن النّعام العربي وظبي الرّيم وظبي العفري والوعل كانت موجودة سابقا في المنطقة. تم تنفيذ برنامج إعادة توطين المها وظباء الرّيم والإدمي في المحميّة بنجاح خلال عامي 1995م، 1996م. وقد تأقلمت تلك الحيوانات وتكاثرت طبيعيا في بيئة المحمية وتتنامى بشكل مستمرّ.',
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
