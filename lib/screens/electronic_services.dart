import 'package:flutter/material.dart';
import 'package:najran/screens/services/appointement_booking_form.dart';
import 'package:najran/screens/services/compensation_form.dart';
import 'package:najran/screens/services/complaint_service_form.dart';
import 'package:najran/screens/services/death_service_form.dart';
import 'package:najran/widgets/cards/service_card.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class ElectronicServices extends StatefulWidget {
  @override
  State<ElectronicServices> createState() => _ElectronicServicesState();
}

class _ElectronicServicesState extends State<ElectronicServices>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _animatedCard(Widget child, int index) {
    final interval = 0.1 * index; // délai progressif
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(interval, 1.0, curve: Curves.easeOut),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final services = [
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
        startService: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppointementBookingForm()),
          );
        },
      ),
      ServiceCard(
        title: 'خدمة طلب تعويض الأضرار',
        description: 'نص إضافي لمحتوى الخدمة',
        rating: 3.5,
        reviews: 12,
        iconPath: 'assets/icons/user.svg',
        startService: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CompensationForm()),
          );
        },
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
        startService: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComplaintServiceForm()),
          );
        },
      ),
    ];

    return NajranScaffold(
      title: 'الخدمات الإلكترونية',
      currentIndex: 2,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (int i = 0; i < services.length; i++)
              _animatedCard(services[i], i),
          ],
        ),
      ),
    );
  }
}
