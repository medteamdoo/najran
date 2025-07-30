import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';
import 'package:najran/widgets/service_card.dart';

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
            ),
            ServiceCard(
              title: 'خدمات الزواج',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
            ),
            ServiceCard(
              title: 'خدمة الإستعلام عن معاملة',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
            ),
            ServiceCard(
              title: 'خدمة طلب موعد',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
            ),
            ServiceCard(
              title: 'خدمة طلب تعويض الأضرار',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
            ),
            ServiceCard(
              title: 'خدمة السجناء',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
            ),
            ServiceCard(
              title: 'خدمة الاستدعاء',
              description: 'نص إضافي لمحتوى الخدمة',
              rating: 3.5,
              reviews: 12,
            ),
          ],
        ),
      ),
    );
  }
}
