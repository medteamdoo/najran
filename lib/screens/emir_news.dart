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

class _EmirNewsState extends State<EmirNews> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchEmirNews();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'أخبار أمير المنطقة',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Partie haute avec image de fond et texte (25% de l'écran)
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'صاحب السمو الأمير جلوي بن عبد العزيز بن مساعد.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'السيرة الذاتية :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'صاحب السمو الأمير جلوي بن عبدالعزيز بن مساعد آل سعود.',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1.أولا : البيانات الشخصية:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BulletText(
                        "صاحب السمو الأمير جلوي بن عبدالعزيز بن مساعد آل سعود",
                      ),
                      BulletText("مكان وتاريخ الميلاد: 1958 م حائل."),
                      BulletText(
                        "الحالة الاجتماعية: متزوج : عدد الأبناء (7) عدد البنات (4).",
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '2.ثانياَ: المؤهلات العلمية العسكرية :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BulletText(
                        "مدرسة المضلات وقوات الأمن الخاصة دورة الفرد الأساسي ( خاصة) بتاريخ 1405/3/27هــ.",
                      ),
                      BulletText(
                        "مدرسة المضلات وقوات الأمن الخاصة دورة صاعقة بتاريخ 1405هــ.",
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '3.ثالثاً: المناصب :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BulletText(
                        "بتاريخ 29 محرم 1421هـ الموافق لـ4 مايو 2000م صدر أمر ملكي بتعيينه نائباً لأمير منطقة تبوك بالمرتبة الممتازة.",
                      ),
                      BulletText(
                        "بتاريخ 4 جمادى الأولى 1425هـ الموافق لـ22 يونيو 2004م صدر أمر ملكي بتعيينه نائباً لأمير المنطقة الشرقية بالمرتبة الممتازة.",
                      ),
                      BulletText(
                        "بتاريخ 19 محرم 1436هـ الموافق لـ12 نوفمبر 2014م صدر أمر ملكي بتعيينه أميراً لمنطقة نجران بمرتبة وزير.",
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '4.الشهادات الفخرية :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BulletText(
                        "قيادة القوات المتقدمة في عرعر شكر وتقدير ، تاريخ 1411/10/7هــ.",
                      ),
                      BulletText(
                        "اشترك في القوات المشاركة في الدفاع عن مدينة عرعر ، في عمليات عاصفة الصحراء ضمن مجموعة لواء الإمام فيصل بن تركي المظلي.",
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '5.الأوسمة الفخرية :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BulletText("نواط المعركة ."),
                      BulletText(
                        "قيادة الكتيبة الخامسة مظلات عرعر شكر وتقدير ، تاريخ 1411/10/7هــ.",
                      ),
                      BulletText("وسام تحرير الكويت."),
                    ],
                  ),
                  SizedBox(height: 8),
                  const Divider(height: 1),
                  SizedBox(height: 16),
                  Text(
                    'أخبار الأمير',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  BlocBuilder<NewsCubit, NewsState>(
                    builder: (context, state) {
                      if (state is NewsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is NewsError) {
                        return Center(child: Text("Erreur: ${state.message}"));
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
                            return NewsCard(
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
