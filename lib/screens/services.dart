import 'package:flutter/material.dart';
import 'package:najran/widgets/najran_scaffold.dart';

class ScrollableServicePage extends StatefulWidget {
  @override
  _ScrollableServicePageState createState() => _ScrollableServicePageState();
}

class _ScrollableServicePageState extends State<ScrollableServicePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _descriptionKey = GlobalKey();
  final GlobalKey _termsKey = GlobalKey();
  final GlobalKey _documentsKey = GlobalKey();
  final GlobalKey _usageKey = GlobalKey();

  int _selectedTab = 0;

  void _scrollTo(GlobalKey key, int tabIndex) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _selectedTab = tabIndex;
      });
    }
  }

  Widget buildTab(String title, int index, GlobalKey key) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => _scrollTo(key, index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.green : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      currentIndex: 4,
      child: SafeArea(
        child: Column(
          children: [
            // Boutons en haut
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text("بدء الخدمة"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                    ),
                    child: Text("تحميل دليل الخدمة"),
                  ),
                ],
              ),
            ),

            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildTab("الوصف", 0, _descriptionKey),
                  buildTab("الشروط والأحكام", 1, _termsKey),
                  buildTab("الوثائق المطلوبة", 2, _documentsKey),
                  buildTab("آلية استخدام الخدمة", 3, _usageKey),
                ],
              ),
            ),

            // Contenu scrollable
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildSectionTitle("وصف الخدمة", _descriptionKey),
                    buildParagraph(
                      "وهذا مثال على نمط الفقرة الذي يتبعه نظام التصميم، نفس النمط منسق عبر جميع أقسام النص الأساسي. "
                      "وهذا مثال على نمط الفقرة الذي يتبعه نظام التصميم، نفس النمط منسق عبر جميع أقسام النص الأساسي.",
                    ),
                    SizedBox(height: 32),
                    buildSectionTitle("الشروط والأحكام", _termsKey),
                    ...List.generate(6, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "${i + 1}- نص مثال للشروط أو الحكم.",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }),
                    SizedBox(height: 32),
                    buildSectionTitle("الوثائق المطلوبة", _documentsKey),
                    buildParagraph("قائمة الوثائق المطلوبة لإكمال الخدمة."),
                    SizedBox(height: 32),
                    buildSectionTitle("آلية استخدام الخدمة", _usageKey),
                    buildParagraph("شرح آلية استخدام الخدمة بطريقة مبسطة."),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, Key key) {
    return Container(
      key: key,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.green[800],
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
