import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleSvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;

  const CircleSvgIcon({
    Key? key,
    required this.assetPath,
    this.size = 40, // diamètre du cercle
    this.iconSize = 20, // taille de l'icône
    this.backgroundColor = const Color(0xFF1B8E4B), // vert
    this.iconColor = Colors.white, // icône blanche
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      padding: EdgeInsets.all((size - iconSize) / 2),
      child: SvgPicture.asset(
        assetPath,
        color: iconColor,
        width: iconSize,
        height: iconSize,
      ),
    );
  }
}
