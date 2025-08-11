// najran_bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/electronic_services.dart';
import 'package:najran/screens/home_page.dart';
import 'package:najran/screens/list_screen.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_screen.dart';
import 'package:najran/services/auth_service.dart';

class NajranBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const NajranBottomNavBar({Key? key, required this.currentIndex})
    : super(key: key);

  void _navigateTo(int index, BuildContext context) {
    if (index == currentIndex) return;

    Widget page;
    switch (index) {
      case 0:
        page = BlocProvider(
          create: (_) =>
              NewsCubit(odooApiService: context.read<OdooApiService>())
                ..fetchNews(),
          child: HomePage(),
        );
        break;
      case 1:
        // Fournir le NewsCubit avec OdooApiService
        page = BlocProvider(
          create: (_) =>
              NewsCubit(odooApiService: context.read<OdooApiService>())
                ..fetchNews(),
          child: NewsScreen(),
        );
        break;
      case 2:
        page = ElectronicServices();
        break;
      case 3:
        page = ListScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF1B8354),
      currentIndex: currentIndex,
      onTap: (index) => _navigateTo(index, context),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "الرئيسية",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          label: "الأخبار",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.web),
          label: "الخدمات الإلكترونية",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: "القائمة"),
      ],
    );
  }
}
