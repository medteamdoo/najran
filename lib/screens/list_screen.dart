import 'package:flutter/material.dart';
import 'package:najran/screens/beneficiary_voice.dart';
import 'package:najran/screens/commincation_screen.dart';
import 'package:najran/screens/electronic_services.dart';
import 'package:najran/screens/imara_links_page.dart';
import 'package:najran/screens/media_center.dart';
import 'package:najran/screens/najran_links_page.dart';
import 'package:najran/screens/procedures_guide.dart';
import 'package:najran/widgets/cards/menu_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: 'القائمة',
      currentIndex: 3,
      onTabSelected: (index) {
        print('Naviguer vers index $index');
      },

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                  children: [
                    MenuCard(
                      Path: 'assets/icons/laptop.svg',
                      title: "الخدمات الإلكترونية",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElectronicServices(),
                        ),
                      ),
                    ),
                    MenuCard(
                      Path: 'assets/icons/book.svg',
                      title: "المركز الإعلامي",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MediaCenter()),
                      ),
                    ),
                    MenuCard(
                      Path: 'assets/icons/map.svg',
                      title: "منطقة نجران",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NajranLinksPage(),
                        ),
                      ),
                    ),
                    MenuCard(
                      Path: 'assets/icons/localisation.svg',
                      title: "الإمارة",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImaraLinksPage(),
                        ),
                      ),
                    ),
                    MenuCard(
                      Path: 'assets/icons/person.svg',
                      title: "صوت المستفيد",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BeneficiaryVoice(),
                        ),
                      ),
                    ),
                    MenuCard(
                      Path: 'assets/icons/document.svg',
                      title: "المستندات",
                    ),
                    MenuCard(
                      Path: 'assets/icons/A.svg',
                      title: "دليل الاجراءات",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProceduresGuide(),
                        ),
                      ),
                    ),
                    MenuCard(
                      Path: 'assets/icons/chat.svg',
                      title: "تواصل معنا",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TawasolFormPage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
