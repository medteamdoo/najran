import 'package:flutter/material.dart';
import 'package:najran/screens/Governorates.dart';
import 'package:najran/screens/citrus.dart';
import 'package:najran/screens/crafts.dart';
import 'package:najran/screens/folk_arts.dart';
import 'package:najran/screens/hama_cultural_zone.dart';
import 'package:najran/screens/historical_imara_castle.dart';
import 'package:najran/screens/industry.dart';
import 'package:najran/screens/king_abdulaziz_park.dart';
import 'package:najran/screens/king_fahd_park.dart';
import 'package:najran/screens/mud_houses.dart';
import 'package:najran/screens/najran_info.dart';
import 'package:najran/screens/najran_valley_dam.dart';
import 'package:najran/screens/okhdoud_city.dart';
import 'package:najran/screens/popular_food.dart';
import 'package:najran/screens/prince_jalawi_park.dart';
import 'package:najran/screens/reserve_arouk_beni_maared.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class NajranLinksPage extends StatefulWidget {
  @override
  State<NajranLinksPage> createState() => _NajranLinksPageState();
}

class _NajranLinksPageState extends State<NajranLinksPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> items = [
    {"title": "نبذة عن نجران", "page": RegionInfoScreen()},
    {"title": "منتزه الملك فهد", "page": KingFahdPark()},
    {"title": "منتزه الأمير جلوي", "page": PrinceJalawiPark()},
    {"title": "مدينة الأخدود الأثرية", "page": OkhdoudCity()},
    {"title": "محميه عروق بني معارض", "page": ReserveAroukBeniMaared()},
    {"title": "قصر الامارة التاريخي", "page": HistoricalImaraCastle()},
    {"title": "سد وادي نجران", "page": NajranValleyDam()},
    {"title": "حمى", "page": HamaCulturalZone()},
    {"title": "حديقة الملك عبدالعزيز", "page": KingAbdulazizPark()},
    {"title": "المحافظات", "page": Governorates()},
    {"title": "الفنون الشعبية", "page": FolkArts()},
    {"title": "الصناعة في نجران", "page": Industry()},
    {"title": "الحمضيات في نجران", "page": Citrus()},
    {"title": "الحرف والأسواق الشعبية", "page": Crafts()},
    {"title": "البيوت الطينية", "page": MudHouses()},
    {"title": "الأكلات الشعبية", "page": PopularFood()},
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
      final end = (start + 0.5).clamp(0.0, 1.0);
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
      final end = (start + 0.5).clamp(0.0, 1.0);
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
      title: 'منطقة نجران',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => items[index]["page"],
                    ),
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
