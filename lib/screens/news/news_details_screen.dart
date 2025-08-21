import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/models/news.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_screen.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/cards/home_news_card.dart';
import 'package:najran/widgets/carousels/news_carousel.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/widgets/social_share_buttons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsDetailScreen extends StatefulWidget {
  final News news;

  const NewsDetailScreen({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  String extractYoutubeId(String url) {
    try {
      // D'abord essayer avec la méthode de YoutubePlayer
      String? id = YoutubePlayer.convertUrlToId(url);
      if (id != null && id.isNotEmpty) return id;

      // Parser l'URL
      final uri = Uri.parse(url);

      // Format court youtu.be
      if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.first;
      }

      // Format long avec paramètre "v"
      return uri.queryParameters['v'] ?? '';
    } catch (_) {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.news.isYoutubeVideo && widget.news.videoUrl != null) {
      final videoId = extractYoutubeId(widget.news.videoUrl!);

      _controller =
          YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              enableCaption: true,
            ),
          )..addListener(() {
            if (_isPlayerReady && !_controller.value.isFullScreen) {
              setState(() {});
            }
          });
    }
  }

  @override
  void dispose() {
    if (widget.news.isYoutubeVideo) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    return NajranScaffold(
      title: 'الأخبار',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.isYoutubeVideo && news.videoUrl != null)
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
              )
            else if (news.image != null)
              Image.memory(news.image!)
            else
              Container(
                height: 200,
                color: Colors.grey,
                child: const Center(child: Text('Aucune image disponible')),
              ),
            const SizedBox(height: 16),
            Text(
              news.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            if (news.descriptionText != null)
              Text(news.descriptionText!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'مشاركة على :',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SocialShareButtons(
                  title: news.title,
                  description: news.descriptionText ?? '',
                  url: news.isYoutubeVideo ? news.videoUrl : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "المزيد من الأخبار ",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[800],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (_) => NewsCubit(
                            odooApiService: context.read<OdooApiService>(),
                          )..fetchNews(),
                          child: NewsScreen(),
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    ' عرض الكل',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NewsError) {
                    return Center(child: Text("Erreur: ${state.message}"));
                  }
                  if (state is NewsLoaded) {
                    final newsList = state.news;

                    return CustomCarousel(
                      items: newsList.map((news) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: HomeNewsCard(
                            news: news,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => NewsCubit(
                                      odooApiService: context
                                          .read<OdooApiService>(),
                                    )..fetchNews(),
                                    child: NewsDetailScreen(news: news),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return SizedBox(height: 300);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
