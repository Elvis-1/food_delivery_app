import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroungColor;
  final Color iconColor;
  final double size;

  const AppIcon(
      {required this.icon,
      this.backgroungColor = const Color(0xFFfcf4e4),
      this.iconColor = const Color(0xFF756d54),
      this.size = 40,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroungColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: Dimension.iconSize16,
      ),
    );
  }
}
