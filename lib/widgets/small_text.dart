import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  String text;
  double height;
  double size;

  SmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.height = 1.2,
      this.size = 12.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontFamily: "Roboto",
          height: height,
          fontWeight: FontWeight.w400,
          fontSize: size),
    );
  }
}
