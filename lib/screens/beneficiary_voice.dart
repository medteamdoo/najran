import 'package:flutter/material.dart';
import 'package:najran/screens/helpdesk.dart';
import 'package:najran/screens/inquiry.dart';
import 'package:najran/screens/suggestion.dart';
import 'package:najran/widgets/cards/media_center_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class BeneficiaryVoice extends StatefulWidget {
  @override
  State<BeneficiaryVoice> createState() => _BeneficiaryVoiceState();
}

class _BeneficiaryVoiceState extends State<BeneficiaryVoice>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<_CardData> cards = [
    _CardData(
      title: 'بلاغ فني',
      iconPath: 'assets/icons/casque.svg',
      page: helpDeskFormPage(),
    ),
    _CardData(
      title: 'إستفسار',
      iconPath: 'assets/icons/question.svg',
      page: InquiryFormPage(),
    ),
    _CardData(
      title: 'إقتراح',
      iconPath: 'assets/icons/propose.svg',
      page: SuggestionFormPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
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
      title: 'صوت المستفيد',
      currentIndex: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (int i = 0; i < cards.length; i++)
              _animatedCard(
                MediaCenterCard(
                  title: cards[i].title,
                  buttonTitle: 'إبدأ الخدمة ',
                  iconPath: cards[i].iconPath,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => cards[i].page),
                  ),
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
  final Widget page;

  _CardData({required this.title, required this.iconPath, required this.page});
}
