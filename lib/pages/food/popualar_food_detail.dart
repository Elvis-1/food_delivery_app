import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';

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
              )),
          Positioned(
              top: Dimension.height45,
              left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios),
                  AppIcon(icon: Icons.shopping_cart_outlined),
                ],
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimension.popularFoodContainer - 20,
              child: Container(
                padding: EdgeInsets.only(
                    right: Dimension.width20,
                    left: Dimension.width20,
                    top: Dimension.width20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimension.radius20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'Chinese Side'),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: 15,
                                  )),
                        ),
                        SizedBox(
                          width: Dimension.width10,
                        ),
                        SmallText(text: '4.5'),
                        SizedBox(
                          width: Dimension.width10,
                        ),
                        SmallText(text: '1287'),
                        SizedBox(
                          width: Dimension.width10,
                        ),
                        SmallText(text: 'comments')
                      ],
                    ),
                    SizedBox(
                      height: Dimension.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: "1.7km",
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor2)
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
