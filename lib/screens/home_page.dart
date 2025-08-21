import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najran/screens/electronic_services.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_details_screen.dart';
import 'package:najran/screens/news/news_screen.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/cards/home_news_card.dart';
import 'package:najran/widgets/cards/home_service_card.dart';
import 'package:najran/widgets/circle_svg_icon.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/widgets/carousels/news_carousel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    context.read<NewsCubit>().fetchNews();

    return NajranScaffold(
      appBar: false,
      currentIndex: 0,
      onTabSelected: (index) {
        print('Naviguer vers index $index');
      },

      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.24,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/saudia_flag.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.24,
                    width: double.infinity,
                    color: Color(0xFF1b8153).withOpacity(0.9),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/images/white_logo.png',
                                  width: 70,
                                  height: 70,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleSvgIcon(
                                      assetPath: 'assets/icons/language.svg',
                                    ),
                                    SizedBox(width: 12),
                                    CircleSvgIcon(
                                      assetPath: 'assets/icons/notif.svg',
                                    ),
                                    SizedBox(width: 12),
                                    CircleSvgIcon(
                                      assetPath: 'assets/icons/search.svg',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              "مرحباً بك",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              CurrentUserHolder.instance.user?.name ??
                                  "اسم المستخدم",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "أخبار الإمارة",
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
              ),
              const SizedBox(height: 5),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
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

              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " الخدمات الإلكترونية ",
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
                            builder: (context) => ElectronicServices(),
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
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SizedBox(width: 15),
                    HomeServiceCard(
                      title: 'خدمات الوفيات',
                      description: 'نص إضافي لمحتوى الخدمة',
                      rating: 3.5,
                      reviews: 12,
                      iconPath: 'assets/icons/folder.svg',
                    ),
                    SizedBox(width: 15),
                    HomeServiceCard(
                      title: 'خدمات الزواج',
                      description: 'نص إضافي لمحتوى الخدمة',
                      rating: 3.5,
                      reviews: 12,
                      iconPath: 'assets/icons/persons.svg',
                    ),
                    SizedBox(width: 15),
                    HomeServiceCard(
                      title: 'خدمة الإستعلام عن معاملة',
                      description: 'نص إضافي لمحتوى الخدمة',
                      rating: 3.5,
                      reviews: 12,
                      iconPath: 'assets/icons/check.svg',
                    ),
                    SizedBox(width: 15),
                    HomeServiceCard(
                      title: 'خدمة طلب موعد',
                      description: 'نص إضافي لمحتوى الخدمة',
                      rating: 3.5,
                      reviews: 12,
                      iconPath: 'assets/icons/calendar.svg',
                    ),
                    SizedBox(width: 15),
                    HomeServiceCard(
                      title: 'خدمة طلب تعويض الأضرار',
                      description: 'نص إضافي لمحتوى الخدمة',
                      rating: 3.5,
                      reviews: 12,
                      iconPath: 'assets/icons/user.svg',
                    ),
                    SizedBox(width: 15),
                    HomeServiceCard(
                      title: 'خدمة السجناء',
                      description: 'نص إضافي لمحتوى الخدمة',
                      rating: 3.5,
                      reviews: 12,
                      iconPath: 'assets/icons/prison.svg',
                    ),
                    SizedBox(width: 15),
                    HomeServiceCard(
                      title: 'خدمة الاستدعاء',
                      description: 'نص إضافي لمحتوى الخدمة',
                      rating: 3.5,
                      reviews: 12,
                      iconPath: 'assets/icons/mail.svg',
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
