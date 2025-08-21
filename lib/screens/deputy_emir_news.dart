import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_details_screen.dart';
import 'package:najran/widgets/cards/news_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class DeputyEmirNews extends StatefulWidget {
  const DeputyEmirNews({super.key});

  @override
  State<DeputyEmirNews> createState() => _DeputyEmirNewsState();
}

class _DeputyEmirNewsState extends State<DeputyEmirNews> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchDeputyEmirNews();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'نائب أمير المنطقة',
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
                  'assets/images/deputy_emir.jpg',
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
                    'صاحب السمو الملكي الأمير تركي بن هذلول بن عبد العزيز بن عبد الرحمن ال سعود.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "لأهالي منطقة نجران أكلات شعبية، منها ما تتشابه به مع المناطق الأخرى، ومنها ماهو خاص بالمنطقة حيث لا تزال الأسرة النجرانية متمسكة بعاداتها وتقاليدها الأصيلة.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  const Divider(height: 1),
                  SizedBox(height: 16),
                  Text(
                    'أخبار نائب أمير المنطقة',
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
                        final DeputyEmirNews = context
                            .read<NewsCubit>()
                            .deputyEmirNews;
                        if (DeputyEmirNews.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text("لا توجد أخبار حالياً"),
                          );
                        }
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: DeputyEmirNews.length,
                          itemBuilder: (context, index) {
                            final news = DeputyEmirNews[index];
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
