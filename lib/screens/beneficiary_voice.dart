import 'package:flutter/material.dart';
import 'package:najran/screens/helpdesk.dart';
import 'package:najran/screens/inquiry.dart';
import 'package:najran/screens/suggestion.dart';
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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => helpDeskFormPage()),
              ),
            ),
            MediaCenterCard(
              title: 'إستفسار',
              buttonTitle: 'إبدأ الخدمة ',
              iconPath: 'assets/icons/question.svg',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InquiryFormPage()),
              ),
            ),
            MediaCenterCard(
              title: 'إقتراح',
              buttonTitle: 'إبدأ الخدمة ',
              iconPath: 'assets/icons/propose.svg',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuggestionFormPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
