import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  String text;
  TextOverflow textOverflow;
  double size;

  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.textOverflow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: 1,
      style: TextStyle(
          color: color,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          fontSize: size == 0 ? Dimension.font20 : size),
    );
  }
}
