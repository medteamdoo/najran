import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_details_screen.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/widgets/cards/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchNews();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<NewsCubit>().fetchNews(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<NewsCubit>().refreshNews();
  }

  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: ' الأخبار',
      currentIndex: 1,
      child: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.green,
                    size: 60,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "جاري تحميل البيانات...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }

          if (state is NewsError) {
            return Center(child: Text('Erreur: 0{state.message}'));
          }

          if (state is NewsLoaded) {
            final newsList = state.news;
            final hasReachedMax = state.hasReachedMax;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: newsList.length + (hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= newsList.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final news = newsList[index];
                  return NewsCard(
                    news: news,
                    onTap: () {
                      final newsCubit = context.read<NewsCubit>();

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // pour prendre presque tout l'écran
                        backgroundColor: Colors
                            .transparent, // important pour arrondir uniquement le container
                        builder: (context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.9,
                            maxChildSize: 0.95,
                            minChildSize: 0.5,
                            expand: false,
                            builder: (context, scrollController) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      20,
                                    ), // coins arrondis en haut
                                  ),
                                ),
                                child: NewsDetailScreen(news: news),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          }

          if (state is NewsLoadingMore) {
            final cubit = context.read<NewsCubit>();
            final newsList = cubit.news;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: newsList.length + 1,
                itemBuilder: (context, index) {
                  if (index >= newsList.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final news = newsList[index];
                  return NewsCard(
                    news: news,
                    onTap: () {
                      // Gérer la navigation vers le détail
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
