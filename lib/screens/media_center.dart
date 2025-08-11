import 'package:flutter/material.dart';
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
            ),
            MediaCenterCard(
              title: 'البوم الصور',
              buttonTitle: 'عرض الصور',
              iconPath: 'assets/icons/image.svg',
            ),
            MediaCenterCard(
              title: 'البوم الفيديوهات',
              buttonTitle: 'عرض الفيديوهات',
              iconPath: 'assets/icons/video.svg',
            ),
          ],
        ),
      ),
    );
  }
}
