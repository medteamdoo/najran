import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_details_screen.dart';
import 'package:najran/services/auth_service.dart';
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
            return const Center(child: CircularProgressIndicator());
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => NewsCubit(
                              odooApiService: context.read<OdooApiService>(),
                            )..fetchNews(),
                            child: NewsDetailScreen(news: news),
                          ),
                        ),
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
