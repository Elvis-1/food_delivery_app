import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AccountWidget({Key? key, required this.bigText, required this.appIcon})
      : super(key: key);
  AppIcon appIcon;
  BigText bigText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimension.width20,
          top: Dimension.height10,
          bottom: Dimension.height10),
      child: Row(children: [
        appIcon,
        SizedBox(
          width: Dimension.width20,
        ),
        bigText
      ]),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 1,
          offset: Offset(0, 2),
          color: Colors.grey.withOpacity(0.2),
        )
      ]),
    );
  }
}
