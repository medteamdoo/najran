import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_details_screen.dart';
import 'package:najran/widgets/cards/news_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class EmirNews extends StatefulWidget {
  const EmirNews({super.key});

  @override
  State<EmirNews> createState() => _EmirNewsState();
}

class _EmirNewsState extends State<EmirNews>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Charger les données
    context.read<NewsCubit>().fetchEmirNews();

    // Initialiser l’animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Démarrer l’animation
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
      title: 'أخبار أمير المنطقة',
      currentIndex: 3,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image du haut
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/emir_najran.jpg',
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Contenu textuel animé
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        'صاحب السمو الأمير جلوي بن عبد العزيز بن مساعد.',
                      ),
                      _sectionTitle('السيرة الذاتية :', size: 20),
                      const BulletText(
                        "صاحب السمو الأمير جلوي بن عبدالعزيز بن مساعد آل سعود.",
                      ),
                      const SizedBox(height: 8),

                      _sectionTitle('1. أولا : البيانات الشخصية:', size: 20),
                      const BulletText(
                        "صاحب السمو الأمير جلوي بن عبدالعزيز بن مساعد آل سعود",
                      ),
                      const BulletText("مكان وتاريخ الميلاد: 1958 م حائل."),
                      const BulletText(
                        "الحالة الاجتماعية: متزوج : عدد الأبناء (7) عدد البنات (4).",
                      ),
                      const SizedBox(height: 8),

                      _sectionTitle(
                        '2. ثانياَ: المؤهلات العلمية العسكرية :',
                        size: 20,
                      ),
                      const BulletText(
                        "مدرسة المضلات وقوات الأمن الخاصة دورة الفرد الأساسي ( خاصة) بتاريخ 1405/3/27هــ.",
                      ),
                      const BulletText(
                        "مدرسة المضلات وقوات الأمن الخاصة دورة صاعقة بتاريخ 1405هــ.",
                      ),
                      const SizedBox(height: 8),

                      _sectionTitle('3. ثالثاً: المناصب :', size: 20),
                      const BulletText(
                        "صدر أمر ملكي بتعيينه نائباً لأمير منطقة تبوك بالمرتبة الممتازة (2000م).",
                      ),
                      const BulletText(
                        "صدر أمر ملكي بتعيينه نائباً لأمير المنطقة الشرقية (2004م).",
                      ),
                      const BulletText(
                        "صدر أمر ملكي بتعيينه أميراً لمنطقة نجران بمرتبة وزير (2014م).",
                      ),
                      const SizedBox(height: 8),

                      _sectionTitle('4. الشهادات الفخرية :', size: 20),
                      const BulletText(
                        "قيادة القوات المتقدمة في عرعر شكر وتقدير ، تاريخ 1411/10/7هــ.",
                      ),
                      const BulletText(
                        "اشترك في الدفاع عن مدينة عرعر ضمن عمليات عاصفة الصحراء.",
                      ),
                      const SizedBox(height: 8),

                      _sectionTitle('5. الأوسمة الفخرية :', size: 20),
                      const BulletText("نوط المعركة ."),
                      const BulletText("وسام تحرير الكويت."),
                      const SizedBox(height: 8),

                      const Divider(height: 1),
                      const SizedBox(height: 16),

                      _sectionTitle('أخبار الأمير', size: 22),
                      const SizedBox(height: 8),

                      BlocBuilder<NewsCubit, NewsState>(
                        builder: (context, state) {
                          if (state is NewsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is NewsError) {
                            return Center(
                              child: Text("Erreur: ${state.message}"),
                            );
                          }
                          if (state is NewsLoaded) {
                            final emirNews = context.read<NewsCubit>().emirNews;
                            if (emirNews.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text("لا توجد أخبار حالياً"),
                              );
                            }
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: emirNews.length,
                              itemBuilder: (context, index) {
                                final news = emirNews[index];
                                return FadeTransition(
                                  opacity: CurvedAnimation(
                                    parent: _controller,
                                    curve: Interval(
                                      (index * 0.1).clamp(0.0, 1.0),
                                      ((index * 0.1) + 0.5).clamp(0.0, 1.0),
                                      curve: Curves.easeIn,
                                    ),
                                  ),
                                  child: NewsCard(
                                    news: news,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: context.read<NewsCubit>(),
                                            child: NewsDetailScreen(news: news),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          }
                          return const SizedBox();
                        },
                      ),
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

  Widget _sectionTitle(String text, {double size = 24}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF1B8354),
        ),
      ),
    );
  }
}

class BulletText extends StatelessWidget {
  final String text;
  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16, height: 1.4)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
