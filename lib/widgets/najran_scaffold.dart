import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:najran/widgets/najran_bottom_navbar.dart';

class NajranScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final Function(int)? onTabSelected;
  final String? title;
  final bool appBar;

  const NajranScaffold({
    required this.child,
    this.currentIndex = 0,
    this.onTabSelected,
    this.title,
    Key? key,
    this.appBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar
            ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                titleSpacing: 10,
                automaticallyImplyLeading: false,
                title: title != null
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title!,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              _IconButton(
                                icon: Icons.arrow_forward,
                                onPressed: () =>
                                    Navigator.of(context).maybePop(),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          const Divider(height: 1),
                        ],
                      )
                    : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Spacer(),
                          _AppBarIcon(assetPath: 'assets/icons/search.svg'),
                          SizedBox(width: 8),
                          _AppBarIcon(assetPath: 'assets/icons/language.svg'),
                          SizedBox(width: 8),
                          _AppBarIcon(assetPath: 'assets/icons/person.svg'),
                        ],
                      ),
              )
            : null,
        body: child,
        bottomNavigationBar: NajranBottomNavBar(currentIndex: currentIndex),
      ),
    );
  }
}

class _AppBarIcon extends StatelessWidget {
  final String assetPath;

  const _AppBarIcon({required this.assetPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(8),
      child: SvgPicture.asset(
        assetPath,
        fit: BoxFit.contain,
        width: 20,
        height: 20,
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _IconButton({required this.icon, required this.onPressed, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
        splashRadius: 20,
        color: Colors.black,
      ),
    );
  }
}
