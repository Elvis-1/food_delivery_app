import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
//import 'package:medicare/utils/dimensions.dart';
//import 'package:medicare/widgets/small_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  //final Color color;
  // final Color text_color;

  final Color iconColor;
  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    //required this.color,
    // required this.text_color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(5),
      width: Dimension.width10 * 7,
      height: Dimension.height30,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: Dimension.height15,
          ),
          SizedBox(
            width: Dimension.width10 / 2,
          ),
          SmallText(
            text: text,
            // color: text_color,
          )
        ],
      ),
    );
  }
}
