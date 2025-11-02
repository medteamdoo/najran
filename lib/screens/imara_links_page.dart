import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/deputy_emir_news.dart';
import 'package:najran/screens/digital_vision.dart';
import 'package:najran/screens/emir_news.dart';
import 'package:najran/screens/najran_princes.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/tasks.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class ImaraLinksPage extends StatefulWidget {
  ImaraLinksPage({super.key});

  @override
  State<ImaraLinksPage> createState() => _ImaraLinksPageState();
}

class _ImaraLinksPageState extends State<ImaraLinksPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> items = [
    {"title": "أخبار أمير المنطقة", "page": "emir"},
    {"title": "نائب أمير المنطقة", "page": "deputyEmir"},
    {"title": "أمراء منطقة نجران", "page": "princes"},
    {"title": "مهام الإمارة", "page": "tasks"},
    {"title": "الرؤية والرسالة الرقمية", "page": "digital"},
  ];

  late final AnimationController _controller;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimations = items.asMap().entries.map((entry) {
      final index = entry.key;
      final start = index * 0.05;
      final end = start + 0.5;
      return Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    }).toList();

    _fadeAnimations = items.asMap().entries.map((entry) {
      final index = entry.key;
      final start = index * 0.05;
      final end = start + 0.5;
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeIn),
        ),
      );
    }).toList();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: 'الإمارة',
      currentIndex: 3,
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: const Divider(height: 1),
        ),
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: _fadeAnimations[index],
            child: SlideTransition(
              position: _slideAnimations[index],
              child: ListTile(
                title: Text(
                  items[index]["title"],
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Arial'),
                ),
                visualDensity: const VisualDensity(vertical: -4),
                leading: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Widget page;
                  switch (items[index]["page"]) {
                    case "emir":
                      page = BlocProvider(
                        create: (_) => NewsCubit(
                          odooApiService: context.read<OdooApiService>(),
                        )..fetchEmirNews(),
                        child: const EmirNews(),
                      );
                      break;
                    case "deputyEmir":
                      page = BlocProvider(
                        create: (_) => NewsCubit(
                          odooApiService: context.read<OdooApiService>(),
                        )..fetchDeputyEmirNews(),
                        child: const DeputyEmirNews(),
                      );
                      break;
                    case "princes":
                      page = NajranPrinces();
                      break;
                    case "tasks":
                      page = Tasks();
                      break;
                    case "digital":
                      page = DigitalVision();
                      break;
                    default:
                      page = Container();
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => page),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
