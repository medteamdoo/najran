import 'package:flutter/material.dart';
import 'package:najran/widgets/cards/media_center_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class BeneficiaryVoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: 'صوت المستفيد',
      currentIndex: 0,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            MediaCenterCard(
              title: 'بلاغ فني',
              buttonTitle: 'إبدأ الخدمة ',
              iconPath: 'assets/icons/casque.svg',
            ),
            MediaCenterCard(
              title: 'إستفسار',
              buttonTitle: 'إبدأ الخدمة ',
              iconPath: 'assets/icons/question.svg',
            ),
            MediaCenterCard(
              title: 'إقتراح',
              buttonTitle: 'إبدأ الخدمة ',
              iconPath: 'assets/icons/propose.svg',
            ),
          ],
        ),
      ),
    );
  }
}
