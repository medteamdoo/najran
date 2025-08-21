import 'package:flutter/material.dart';

class ServiceModel {
  final String title;
  final List<String> conditions;
  final List<String> documents;

  ServiceModel({
    required this.title,
    required this.conditions,
    required this.documents,
  });
}

class ProceduresGuide extends StatefulWidget {
  const ProceduresGuide({super.key});

  @override
  State<ProceduresGuide> createState() => _ServicePageState();
}

class _ServicePageState extends State<ProceduresGuide> {
  final services = [
    ServiceModel(
      title: "طلب فتح سجل تجاري رئيسي",
      conditions: [
        "قم بالدخول الى البوابة الوطنية للتسجيل الموحد عبر منصة أبشر.",
        "تحديد نوع الإسم التجاري (اسم محجوز – اسم قائم – اسم شخصي).",
        "اختيار النشاط في المستوى الأول والثاني والثالث.",
      ],
      documents: [
        "الدخول الى البوابة الوطنية للتسجيل الموحد عبر منصة أبشر.",
        "تحديد نوع الإسم التجاري.",
      ],
    ),
    ServiceModel(
      title: "طلب فتح سجل تجاري فرعي",
      conditions: ["شرط 1", "شرط 2", "شرط 3"],
      documents: ["وثيقة 1", "وثيقة 2"],
    ),
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // ✅ pour arabe
      child: Scaffold(
        appBar: AppBar(title: const Text("الخدمات")),
        body: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            final isExpanded = expandedIndex == index;

            return Card(
              color: Colors.white,
              margin: const EdgeInsets.all(8),
              child: ExpansionTile(
                initiallyExpanded: isExpanded,
                title: Container(
                  color: isExpanded ? const Color(0xFFE5E7EB) : Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    service.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedIndex = expanded ? index : null;
                  });
                },
                children: [
                  // ✅ contenu toujours blanc
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildSection("الشروط والأحكام", service.conditions),
                        const Divider(),
                        _buildSection(
                          "الوثائق المطلوب ارفقها",
                          service.documents,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("بدء الخدمة"),
                                      ),
                                    );
                                  },
                                  child: const Text("بدء الخدمة"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    side: const BorderSide(color: Colors.green),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("تحميل دليل الخدمة"),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "تحميل دليل الخدمة",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          ...items.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final text = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$index- ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Text(text)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
