import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleSvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onTap; // 👈 callback optionnel

  const CircleSvgIcon({
    Key? key,
    required this.assetPath,
    this.size = 40,
    this.iconSize = 20,
    this.backgroundColor = const Color(0xFF1B8E4B),
    this.iconColor = Colors.white,
    this.onTap, // 👈 initialisation
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 👈 exécution de la fonction si définie
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all((size - iconSize) / 2),
        child: SvgPicture.asset(
          assetPath,
          color: iconColor,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}
