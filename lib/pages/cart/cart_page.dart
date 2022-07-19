import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // header section
          Positioned(
              top: Dimension.height20 * 3,
              right: Dimension.width20,
              left: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroungColor: AppColors.mainColor,
                    iconSize: Dimension.iconSize24,
                  ),
                  SizedBox(
                    width: Dimension.width20 * 5,
                  ),
                  AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroungColor: AppColors.mainColor,
                    iconSize: Dimension.iconSize24,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroungColor: AppColors.mainColor,
                    iconSize: Dimension.iconSize24,
                  )
                ],
              )),

          Positioned(
              top: Dimension.width20 * 5,
              right: Dimension.width20,
              left: Dimension.width20,
              bottom: 0,
              child: Container(
                color: Colors.red,
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, index) {
                      return Container(
                        height: Dimension.width20 * 5,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Container(
                              height: Dimension.width20 * 5,
                              width: Dimension.width20 * 5,
                              margin:
                                  EdgeInsets.only(bottom: Dimension.height10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/image/food0.png')),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(Dimension.radius20),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}
