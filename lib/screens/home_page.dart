import 'package:flutter/material.dart';
import 'package:najran/widgets/menu_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/services/auth_service.dart';
import 'package:najran/models/current_user_holder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      currentIndex: 0,
      onTabSelected: (index) {
        print('Naviguer vers index $index');
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF1B8354),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "مرحباً بك",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          CurrentUserHolder.instance.user?.name ??
                              "اسم المستخدم",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2), // épaisseur de la bordure
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                CurrentUserHolder
                                    .instance
                                    .user
                                    ?.imageProvider ??
                                AssetImage('assets/images/user.png'),
                            radius: 30,
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.logout, color: Colors.white),
                          tooltip: 'تسجيل الخروج',
                          onPressed: () async {
                            await OdooApiService().logout();
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                  ),
                  MenuCard(
                    Path: 'assets/icons/book.svg',
                    title: "المركز الإعلامي",
                  ),
                  MenuCard(Path: 'assets/icons/map.svg', title: "منطقة نجران"),
                  MenuCard(
                    Path: 'assets/icons/localisation.svg',
                    title: "الإمارة",
                  ),
                  MenuCard(
                    Path: 'assets/icons/person.svg',
                    title: "صوت المستفيد",
                  ),
                  MenuCard(Path: 'assets/icons/chat.svg', title: "تواصل معنا"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
