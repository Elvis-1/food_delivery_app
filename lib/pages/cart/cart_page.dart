import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

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
                  GestureDetector(
                    onTap: () {
                      Get.to(MainFoodPage());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroungColor: AppColors.mainColor,
                      iconSize: Dimension.iconSize24,
                    ),
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
                margin: EdgeInsets.only(top: Dimension.height15),
                //color: Colors.red,
                child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: GetBuilder<CartController>(
                      builder: (cart) {
                        return ListView.builder(
                            itemCount: cart.getItems.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: Dimension.width20 * 5,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Container(
                                      height: Dimension.width20 * 5,
                                      width: Dimension.width20 * 5,
                                      margin: EdgeInsets.only(
                                          bottom: Dimension.height10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/food0.png')),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Dimension.radius20),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimension.width10,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: Dimension.height20 * 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                            text: cart.getItems[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(text: "Spicey"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    'N ${cart.getItems[index].price}',
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimension.height10,
                                                    bottom: Dimension.height10,
                                                    right: Dimension.width10,
                                                    left: Dimension.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimension.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        // pupularProduct.setQuantity(false);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          Dimension.width10 / 2,
                                                    ),
                                                    BigText(
                                                        text:
                                                            "10"), //pupularProduct.inCartItems.toString()),
                                                    SizedBox(
                                                      width:
                                                          Dimension.width10 / 2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // pupularProduct.setQuantity(true);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                    )),
              ))
        ],
      ),
    );
  }
}
