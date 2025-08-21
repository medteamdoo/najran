import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'مهام الإمارة',
      currentIndex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/najran.jpg',
                  height: screenHeight * 0.25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "قائمة المهام الرئيسية للإمارة:",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B8354),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "  المهام التي تشرف عليها إمارة منطقة نجران:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "1. تمثيل خادم الحرم​ين الشريفين في المنطقة .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "2. التأكد من تحقيق سير العدالة في المنطقة.",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "3. العمل على حفظ الأمن في المنطقة.",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "4. العمل على توفير كافة الخدمات لمواطني المنطقة بالتعاون والتنسيق مع الجهات الحكومية والمشاركة في مراحل التخطيط لكافة الخدمات.",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "5. التأكد من كفاءة وفاعلية الخدمات التي تقدم لمواطني المنطقة ، والعمل على تحسين وتطوير تقديم تلك الخدمات.",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "6.تلقي شكاوي واستدعاءات المواطنين والنظر في أمورهم والعمل على تلبية مطالبهم وحل مشكلاتهم .",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
