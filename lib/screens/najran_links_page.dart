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

class NajranLinksPage extends StatelessWidget {
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
          return ListTile(
            title: Text(
              items[index]["title"],
              textAlign: TextAlign.right, // Alignement arabe
              style: const TextStyle(fontSize: 14, fontFamily: 'Arial'),
            ),
            visualDensity: const VisualDensity(vertical: -4),
            leading: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => items[index]["page"]),
              );
            },
          );
        },
      ),
    );
  }
}

// Exemple de pages vides
class AboutNajranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _placeholderPage("نبذة عن نجران");
  }
}

class KingFahdParkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _placeholderPage("منتزه الملك فهد");
  }
}

// Fonction utilitaire pour créer une page simple
Widget _placeholderPage(String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text("صفحة $title")),
  );
}
