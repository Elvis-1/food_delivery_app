import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_screen.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
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
    // Get.find<PopularProductController>().popularProductList;
    // Get.find<RecommendedFoodController>().recommendedProductList;

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
                        Get.toNamed(RouteHelper.getInitial());
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
            // body

            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
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
                                var _cartList = cart.getItems;

                                return ListView.builder(
                                    itemCount: _cartList.length,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        height: Dimension.width20 * 5,
                                        width: double.maxFinite,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                var popularIndex = Get.find<
                                                        PopularProductController>()
                                                    .popularProductList
                                                    .indexOf(_cartList[index]
                                                        .product!);

                                                if (popularIndex >= 0) {
                                                  Get.toNamed(RouteHelper
                                                      .getPopularFood(
                                                          popularIndex,
                                                          "cartpage"));
                                                } else {
                                                  var recommendedIndex = Get.find<
                                                          RecommendedFoodController>()
                                                      .recommendedProductList
                                                      .indexOf(_cartList[index]
                                                          .product!);
                                                  if (popularIndex < 0) {
                                                    Get.snackbar(
                                                      "History product",
                                                      "Product review is not available",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText: Colors.white,
                                                    );
                                                  } else {
                                                    Get.toNamed(RouteHelper
                                                        .getRecommendedFood(
                                                            recommendedIndex,
                                                            "cartpage"));
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height: Dimension.width20 * 5,
                                                width: Dimension.width20 * 5,
                                                margin: EdgeInsets.only(
                                                    bottom: Dimension.height10),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          // "assets/image/food0.png"

                                                          Get.find<PopularProductController>()
                                                                      .popularProductList
                                                                      .indexOf(_cartList[
                                                                              index]
                                                                          .product!) >=
                                                                  0
                                                              ? AppConstants
                                                                      .POPULAR_FOOD_IMAGE +
                                                                  cart
                                                                      .getItems[
                                                                          index]
                                                                      .img!
                                                              : AppConstants
                                                                      .RECOMMENDED_FOOD_IMAGE +
                                                                  cart
                                                                      .getItems[
                                                                          index]
                                                                      .img!)),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimension.radius20),
                                                ),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  BigText(
                                                    text: cart
                                                        .getItems[index].name!,
                                                    color: Colors.black54,
                                                  ),
                                                  SmallText(text: "Spicey"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text:
                                                            'N ${cart.getItems[index].price}',
                                                        color: Colors.redAccent,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            top: Dimension
                                                                .height10,
                                                            bottom: Dimension
                                                                .height10,
                                                            right: Dimension
                                                                .width10,
                                                            left: Dimension
                                                                .width10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimension
                                                                      .radius20),
                                                          color: Colors.white,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                cart.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);

                                                                // print("being tapped");
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimension
                                                                      .width10 /
                                                                  2,
                                                            ),
                                                            BigText(
                                                                text: _cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString()), //pupularProduct.inCartItems.toString()),
                                                            SizedBox(
                                                              width: Dimension
                                                                      .width10 /
                                                                  2,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                cart.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .signColor,
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
                  : NoDataScreen(text: 'No item in cart');
            }),
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cart) {
          return Container(
            height: Dimension.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimension.height30,
                bottom: Dimension.height30,
                right: Dimension.width20,
                left: Dimension.width20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimension.radius20 * 2),
                  topLeft: Radius.circular(Dimension.radius20 * 2)),
            ),
            child: cart.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimension.height20,
                            bottom: Dimension.height20,
                            right: Dimension.width20,
                            left: Dimension.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimension.width10 / 2,
                            ),
                            BigText(text: "N ${cart.totalAmount}"),
                            SizedBox(
                              width: Dimension.width10 / 2,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // print("tapped");

                          cart.addToHistory();
                        },
                        child: Container(
                            padding: EdgeInsets.only(
                                top: Dimension.height20,
                                bottom: Dimension.height20,
                                right: Dimension.width20,
                                left: Dimension.width20),
                            child: BigText(
                              text: "Check out",
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius20),
                            )),
                      )
                    ],
                  )
                : Container(),
          );
        }));
  }
}
