import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class Governorates extends StatefulWidget {
  @override
  _GovernoratesState createState() => _GovernoratesState();
}

class _GovernoratesState extends State<Governorates>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final List<String> diwanCenters = [
    "مركز بئر عَسكَر",
    "مركز المَشعَلية",
    "مركز أبا السُعود",
    "مركز الحَضن",
    "مركز رِجلاء",
    "مركز الحِصينيه",
    "مركز الغُويلَه",
    "مركز عَاكفَة",
    "مركز أبا الرْشَاش",
    "مركز خَشم العَان",
    "مركز غشيم الغانم",
    "مركز الخَرعاء",
  ];

  final List<String> governorates = [
    "محافظة شرورة",
    "محافظة يدمه",
    "محافظة خباش",
    "محافظة ثار",
    "محافظة بدر الجنوب",
    "محافظة حبونا",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

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
      title: 'محافظات منطقة نجران',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تفاصيل عن محافظات منطقة نجران:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  const SizedBox(height: 8),

                  ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      "المراكز الداخلية التابعة لديوان الإمارة",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: diwanCenters
                        .map(
                          (center) => ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -4),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 0,
                            ),
                            leading: Text("•", style: TextStyle(fontSize: 20)),
                            title: Text(center),
                          ),
                        )
                        .toList(),
                  ),
                  ...governorates.map(
                    (gov) => ExpansionTile(
                      title: Text(
                        gov,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
