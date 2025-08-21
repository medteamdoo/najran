import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class Governorates extends StatelessWidget {
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
    "مركز خَشم العَان ",
    "مركز غشيم الغانم",
    "مركز الخَرعاء ",
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
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: 'محافظات منطقة نجران',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              // Liste des ExpansionTiles
              ...[
                // Bloc des centres
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
                // Les autres gouvernorats
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
              ].expand((tile) => [tile, Divider(height: 1)]).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
