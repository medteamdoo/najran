import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class NajranPrinces extends StatefulWidget {
  const NajranPrinces({super.key});

  @override
  State<NajranPrinces> createState() => _NajranPrincesState();
}

class _NajranPrincesState extends State<NajranPrinces>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation d’apparition fluide
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
      title: 'أمراء منطقة نجران',
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
                      'assets/images/najran_princes.jpg',
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Contenu principal
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'الأمراء الذين تداولو على إمارة منطقة نجران:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B8354),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "تعاقب على إمارة نجران 12 أميراً منذ العام 1352هـ على الترتيب التالي :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Liste des princes (avec animation progressive)
                      ...List.generate(_princes.length, (index) {
                        final prince = _princes[index];
                        return AnimatedOpacity(
                          duration: Duration(milliseconds: 400 + index * 100),
                          opacity: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              '${index + 1}. $prince',
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

// Liste des princes séparée pour plus de clarté
const List<String> _princes = [
  "صاحب السمو الأمير جلوي بن عبدالعزيز بن مساعد آل سعود أميراً لمنطقة نجران منذ عام 1436 هـ حتى الآن.",
  "صاحب السمو الملكي الأمير مشعل بن عبدالله بن عبدالعزيز آل سعود في عام 1430 هـ.",
  "صاحب السمو الملكي الأمير مشعل بن سعود بن عبدالعزيز آل سعود في عام 1417 هـ.",
  "الأمير فهد بن خالد السديري في عام 1399هـ.",
  "الأمير خالد بن أحمد السديري في عام 1383هـ.",
  "الأمير إبراهيم النشمي (مرة أخرى) في عام 1374هـ.",
  "الأمير علي آل مبارك في عام 1373هـ.",
  "الأمير حمد بن محمد الماضي في عام 1370هـ.",
  "الأمير تركي بن محمد الماضي في عام 1358هـ.",
  "الأمير عبدالعزيز الشقيحي في عام 1356هـ.",
  "الأمير إبراهيم النشمي في عام 1355هـ.",
  "الأمير عساف بن حسين أول أمراء المنطقة في عام 1352هـ.",
];
