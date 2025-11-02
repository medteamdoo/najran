import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return NajranScaffold(
      title: 'مهام الإمارة',
      currentIndex: 3,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image d’en-tête
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

                // Contenu
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "قائمة المهام الرئيسية للإمارة:",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "المهام التي تشرف عليها إمارة منطقة نجران:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Liste des tâches animée
                      ...List.generate(_tasks.length, (index) {
                        final task = _tasks[index];
                        return AnimatedOpacity(
                          duration: Duration(milliseconds: 400 + index * 100),
                          opacity: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              '${index + 1}. $task',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> _tasks = [
  "تمثيل خادم الحرمين الشريفين في المنطقة.",
  "التأكد من تحقيق سير العدالة في المنطقة.",
  "العمل على حفظ الأمن في المنطقة.",
  "العمل على توفير كافة الخدمات لمواطني المنطقة بالتعاون والتنسيق مع الجهات الحكومية والمشاركة في مراحل التخطيط لكافة الخدمات.",
  "التأكد من كفاءة وفاعلية الخدمات التي تقدم لمواطني المنطقة، والعمل على تحسين وتطوير تقديم تلك الخدمات.",
  "تلقي شكاوى واستدعاءات المواطنين والنظر في أمورهم والعمل على تلبية مطالبهم وحل مشكلاتهم.",
];
