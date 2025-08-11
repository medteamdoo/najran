import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:najran/screens/home_page.dart';
import 'package:najran/screens/login/login_page.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_screen.dart';
import 'package:najran/screens/splash_screen.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/inactivity_watcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  final initSettings = InitializationSettings(android: androidSettings);
  await FlutterLocalNotificationsPlugin().initialize(initSettings);

  // ✅ Initialiser le service une fois
  final odooApiService = OdooApiService();

  runApp(
    RepositoryProvider.value(
      value: odooApiService,
      child: InactivityWatcher(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Najran App',
      home: const SplashScreen(),
      routes: {
        '/login': (_) => const NajranLoginPage(),
        '/home': (_) => BlocProvider(
          create: (_) =>
              NewsCubit(odooApiService: context.read<OdooApiService>())
                ..fetchNews(),
          child: HomePage(),
        ),
        '/news': (context) => BlocProvider(
          create: (_) =>
              NewsCubit(odooApiService: context.read<OdooApiService>())
                ..fetchNews(),
          child: const NewsScreen(),
        ),
      },
    );
  }
}
