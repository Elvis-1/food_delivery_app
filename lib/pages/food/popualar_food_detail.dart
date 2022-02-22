import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class PopuparFoodDetail extends StatelessWidget {
  const PopuparFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: Dimension.popularFoodContainer,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/food0.png'))),
              ))
        ],
      ),
    );
  }
}
