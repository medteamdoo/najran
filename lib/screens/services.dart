import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        duration: const Duration(milliseconds: 500),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Color(0xFF384250),
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: 40,
              color: isSelected ? Colors.green[800] : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NajranScaffold(
      title: " خدمة طلب ترحيل جثمان",
      currentIndex: 2,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color(0xFFF7FDF9),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFF7FDF9),
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'تحميل دليل الخدمة ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1B8354),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'بدء الخدمة',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Stack(
                children: [
                  // Barre de fond (gris clair)
                  Container(
                    height: 2,
                    margin: const EdgeInsets.only(top: 38),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade300,
                  ),

                  Row(
                    children: [
                      buildTab("الوصف", 0, _descriptionKey),
                      buildTab("الشروط والأحكام", 1, _termsKey),
                      buildTab("الوثائق المطلوب إرفاقها", 2, _documentsKey),
                      buildTab("آلية استخدام الخدمة", 3, _usageKey),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildSectionTitle("وصف الخدمة", _descriptionKey),
                    buildParagraph(
                      "تتيح هذه الخدمة إمكانية التقديم على طلب ترحيل جثمان إلكترونياً بدون زيارة إمارة منطقة نجران ومتابعة الطلب عن طريق الموقع الرسمي للإمارة ."
                      "ملاحظة : لاستخدام الخدمات يتوجب عليك الدخول من خلال النفاذ الوطني الموحد",
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    buildSectionTitle("الشروط والأحكام", _termsKey),
                    buildNumberedList([
                      "بيانات مقدم الطلب (الاسم، رقم الهوية).",
                      "عنوان ذويه في المملكة وفي بلده",
                      "تحديد مسار الرحلة",
                      "تحديد مكان وجود الجثمان",
                      "رقم تأشيرة الدخول",
                    ]),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    buildSectionTitle("الوثائق المطلوب إرفاقها", _documentsKey),
                    buildNumberedList([
                      "تقديم استدعاء",
                      "صورة اقامة المتوفى",
                      "ارفاق صورة من هوية مقدم الطلب",
                      " ارفاق جواز سفر المتوفى أو صورة منها",
                      "موافقة سفارة بلده لترحيله",
                      "​ارفاق شهادة الوفاة",
                      "تحديد مسار الرحلة",
                    ]),
                    const SizedBox(height: 24),
                    buildSectionTitle("آلية استخدام الخدمة", _usageKey),
                    buildSteps([
                      "الدخول إلى البوابة الوطنية للتسجيل.",
                      "اختيار الخدمة المطلوبة.",
                      "تعبئة البيانات.",
                      "رفع المستندات المطلوبة.",
                      "تأكيد الطلب وإرساله.",
                    ]),
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
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF1B8354),
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          height: 1.6,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget buildNumberedList(List<String> items) {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final text = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$index- ",
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget buildSteps(List<String> steps) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: steps.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final text = entry.value;
          final isLast = index == steps.length;

          return Column(
            children: [
              // Cercle avec numéro
              Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF0F9F4),
                ),
                child: Center(
                  child: Text(
                    "$index",
                    style: const TextStyle(
                      color: Color(0xFF1B8354),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Texte de l'étape
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Ligne verticale (sauf pour la dernière étape)
              if (!isLast)
                SvgPicture.asset(
                  width: 70,
                  height: 70,
                  "assets/icons/arrow.svg",
                  color: Color(0xFF1B8354),
                ),
              SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    );
  }
}
