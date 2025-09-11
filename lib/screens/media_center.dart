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

class MediaCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: 'المركز الإعلامي',
      currentIndex: 1,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            MediaCenterCard(
              title: 'الأخبار',
              buttonTitle: 'عرض الأخبار',
              iconPath: 'assets/icons/document.svg',
              onTap: () {
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
            ),
            MediaCenterCard(
              title: 'البوم الصور',
              buttonTitle: 'عرض الصور',
              iconPath: 'assets/icons/image.svg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => ImageCubit(
                        odooApiService: context.read<OdooApiService>(),
                      )..fetchImages(),
                      child: ImageScreen(),
                    ),
                  ),
                );
              },
            ),
            MediaCenterCard(
              title: 'البوم الفيديوهات',
              buttonTitle: 'عرض الفيديوهات',
              iconPath: 'assets/icons/video.svg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => VideoCubit(
                        odooApiService: context.read<OdooApiService>(),
                      )..fetchVideos(),
                      child: VideoScreen(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
