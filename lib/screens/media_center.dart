import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/images/cubit/image_cubit.dart';
import 'package:najran/screens/images/image_screen.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_screen.dart';
import 'package:najran/screens/video/cubit/video_cubit.dart';
import 'package:najran/screens/video/videos_screen.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/cards/media_center_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class MediaCenter extends StatefulWidget {
  @override
  State<MediaCenter> createState() => _MediaCenterState();
}

class _MediaCenterState extends State<MediaCenter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<_CardData> cards = [];

  @override
  void initState() {
    super.initState();
    cards.addAll([
      _CardData(
        title: 'الأخبار',
        iconPath: 'assets/icons/document.svg',
        onTap: () => _openNews(context),
      ),
      _CardData(
        title: 'البوم الصور',
        iconPath: 'assets/icons/image.svg',
        onTap: () => _openImages(context),
      ),
      _CardData(
        title: 'البوم الفيديوهات',
        iconPath: 'assets/icons/video.svg',
        onTap: () => _openVideos(context),
      ),
    ]);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
  }

  void _openNews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) =>
              NewsCubit(odooApiService: context.read<OdooApiService>())
                ..fetchNews(),
          child: NewsScreen(),
        ),
      ),
    );
  }

  void _openImages(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) =>
              ImageCubit(odooApiService: context.read<OdooApiService>())
                ..fetchImages(),
          child: ImageScreen(),
        ),
      ),
    );
  }

  void _openVideos(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) =>
              VideoCubit(odooApiService: context.read<OdooApiService>())
                ..fetchVideos(),
          child: VideoScreen(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedCard(Widget child, int index) {
    final interval = 0.1 * index;
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(interval, 1.0, curve: Curves.easeOut),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: 'المركز الإعلامي',
      currentIndex: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (int i = 0; i < cards.length; i++)
              _animatedCard(
                MediaCenterCard(
                  title: cards[i].title,
                  buttonTitle: 'عرض الخدمة',
                  iconPath: cards[i].iconPath,
                  onTap: cards[i].onTap,
                ),
                i,
              ),
          ],
        ),
      ),
    );
  }
}

class _CardData {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  _CardData({required this.title, required this.iconPath, required this.onTap});
}
