import 'package:flutter/material.dart';
import 'package:najran/screens/death_service/death_service_form.dart';
import 'package:najran/widgets/cards/service_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class ElectronicServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: 'الخدمات الإلكترونية',
      currentIndex: 2,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ServiceCard(
              title: 'خدمات الوفيات',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
              iconPath: 'assets/icons/folder.svg',
              startService: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeathServiceForm()),
                );
              },
            ),
            ServiceCard(
              title: 'خدمات الزواج',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
              iconPath: 'assets/icons/persons.svg',
            ),
            ServiceCard(
              title: 'خدمة الإستعلام عن معاملة',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
              iconPath: 'assets/icons/check.svg',
            ),
            ServiceCard(
              title: 'خدمة طلب موعد',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
              iconPath: 'assets/icons/calendar.svg',
            ),
            ServiceCard(
              title: 'خدمة طلب تعويض الأضرار',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
              iconPath: 'assets/icons/user.svg',
            ),
            ServiceCard(
              title: 'خدمة السجناء',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
              iconPath: 'assets/icons/prison.svg',
            ),
            ServiceCard(
              title: 'خدمة الاستدعاء',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
              iconPath: 'assets/icons/mail.svg',
            ),
          ],
        ),
      ),
    );
  }
}
