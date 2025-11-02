import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:najran/models/search_item.dart';
import 'package:najran/screens/Governorates.dart';
import 'package:najran/screens/citrus.dart';
import 'package:najran/screens/contact_us.dart';
import 'package:najran/screens/crafts.dart';
import 'package:najran/screens/digital_vision.dart';
import 'package:najran/screens/electronic_services.dart';
import 'package:najran/screens/folk_arts.dart';
import 'package:najran/screens/hama_cultural_zone.dart';
import 'package:najran/screens/helpdesk.dart';
import 'package:najran/screens/historical_imara_castle.dart';
import 'package:najran/screens/industry.dart';
import 'package:najran/screens/king_abdulaziz_park.dart';
import 'package:najran/screens/king_fahd_park.dart';
import 'package:najran/screens/list_screen.dart';
import 'package:najran/screens/media_center.dart';
import 'package:najran/screens/mud_houses.dart';
import 'package:najran/screens/najran_info.dart';
import 'package:najran/screens/najran_princes.dart';
import 'package:najran/screens/najran_valley_dam.dart';
import 'package:najran/screens/news/cubit/news_cubit.dart';
import 'package:najran/screens/news/news_details_screen.dart';
import 'package:najran/screens/news/news_screen.dart';
import 'package:najran/screens/okhdoud_city.dart';
import 'package:najran/screens/popular_food.dart';
import 'package:najran/screens/prince_jalawi_park.dart';
import 'package:najran/screens/procedures_guide.dart';
import 'package:najran/screens/reserve_arouk_beni_maared.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/widgets/cards/home_news_card.dart';
import 'package:najran/widgets/cards/home_service_card.dart';
import 'package:najran/widgets/circle_svg_icon.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/models/current_user_holder.dart';
import 'package:najran/widgets/carousels/news_carousel.dart';
import 'package:najran/widgets/search_modal.dart';

class HomePage extends StatelessWidget {
  final OdooApiService _apiService = OdooApiService();
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
                                      onTap: () {
                                        _apiService.logout();
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/login',
                                        );
                                      },
                                    ),
                                    SizedBox(width: 12),
                                    CircleSvgIcon(
                                      assetPath: 'assets/icons/search.svg',
                                      onTap: () {
                                        final List<SearchItem> searchItems = [
                                          SearchItem(
                                            title: 'أخبار الإمارة',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                        create: (_) => NewsCubit(
                                                          odooApiService: context
                                                              .read<
                                                                OdooApiService
                                                              >(),
                                                        )..fetchNews(),
                                                        child: NewsScreen(),
                                                      ),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'الخدمات الإلكترونية',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ElectronicServices(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: "الحرف والأسوق الشعبية ",
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Crafts(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'بلاغ فني',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      helpDeskFormPage(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'الصناعة في منطقة نجران',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Industry(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'الحمضيات في منطقة نجران',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Citrus(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'تواصل معنا',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TawasolFormPage(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'الرؤية والرسالة الرقمية',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DigitalVision(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'الفنون الشعبية',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FolkArts(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'حديقة الملك عبدالعزيز',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      KingAbdulazizPark(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'محافظات منطقة نجران',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Governorates(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'منطقة حمى الثقافية',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HamaCulturalZone(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'قصر الامارة التاريخي',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HistoricalImaraCastle(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'منتزه الملك فهد',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      KingFahdPark(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'القائمة',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ListScreen(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'المركز الإعلامي',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MediaCenter(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'البيوت الطينية',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MudHouses(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'منطقة نجران',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegionInfoScreen(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'أمراء منطقة نجران',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NajranPrinces(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'سد وادي نجران',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NajranValleyDam(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'مدينة الأخدود الأثرية',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OkhdoudCity(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: ' الأكلات الشعبية',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PopularFood(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title:
                                                'منتزه الأمير جلوي بن عبد العزيز',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrinceJalawiPark(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: "دليل الإجراءات",
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProceduresGuide(),
                                                ),
                                              );
                                            },
                                          ),
                                          SearchItem(
                                            title: 'محمية عروق بني معارض',
                                            onTap: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReserveAroukBeniMaared(),
                                                ),
                                              );
                                            },
                                          ),
                                        ];
                                        showSearchOverlay(context, searchItems);
                                      },
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
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.green,
                              size: 60,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "جاري تحميل البيانات...",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
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
                                final newsCubit = context.read<NewsCubit>();

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled:
                                      true, // pour prendre presque tout l'écran
                                  backgroundColor: Colors
                                      .transparent, // important pour arrondir uniquement le container
                                  builder: (context) {
                                    return DraggableScrollableSheet(
                                      initialChildSize: 0.9,
                                      maxChildSize: 0.95,
                                      minChildSize: 0.5,
                                      expand: false,
                                      builder: (context, scrollController) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(
                                                20,
                                              ), // coins arrondis en haut
                                            ),
                                          ),
                                          child: NewsDetailScreen(news: news),
                                        );
                                      },
                                    );
                                  },
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
