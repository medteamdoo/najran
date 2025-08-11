import 'package:flutter/material.dart';
import 'package:najran/screens/beneficiary_voice.dart';
import 'package:najran/screens/commincation_screen.dart';
import 'package:najran/screens/electronic_services.dart';
import 'package:najran/screens/media_center.dart';
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
                  MenuCard(Path: 'assets/icons/map.svg', title: "منطقة نجران"),
                  MenuCard(
                    Path: 'assets/icons/localisation.svg',
                    title: "الإمارة",
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
                  MenuCard(Path: 'assets/icons/A.svg', title: "دليل الاجراءات"),
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
    );
  }
}
