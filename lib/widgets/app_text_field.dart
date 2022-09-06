import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  bool isObscure;
  IconData icon;
  AppTextField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.textController,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimension.width20,
        right: Dimension.width20,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.radius15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextField(
        obscureText: isObscure ? true : false,
        controller: textController,
        decoration: InputDecoration(
          // hintText,
          hintText: hintText,
          // prefix icon
          prefixIcon: Icon(
            icon,
            color: AppColors.yellowColor,
          ),

          // forcus border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.radius15),
              borderSide: BorderSide(width: 1.0, color: Colors.white)),
          // enabled border
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimension.radius15),
              borderSide: BorderSide(width: 1.0, color: Colors.white)),

          // border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimension.radius15),
          ),
        ),
      ),
    );
  }
}
