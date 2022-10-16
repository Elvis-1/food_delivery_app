import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  RecommendedFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendedfood =
        Get.find<RecommendedFoodController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(recommendedfood, Get.find<CartController>());
    print("Page id is " + recommendedfood.products!.id.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      // automaticallyImplyLeading: false,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == "cartpage") {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems > 1)
                        Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  iconColor: Colors.transparent,
                                  size: 20,
                                  backgroungColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  color: Colors.white,
                                  size: 12,
                                ))
                            : Container()
                      ],
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.radius20),
                      topRight: Radius.circular(Dimension.radius20),
                    )),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                    child: BigText(
                        size: Dimension.font26,
                        text: recommendedfood.products!.name!)),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.RECOMMENDED_FOOD_IMAGE +
                    recommendedfood.products!.image!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimension.width20, right: Dimension.width20),
                  child: ExpandableTextWidget(
                    text: recommendedfood.products!.description!,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    right: Dimension.width20 * 2.5,
                    left: Dimension.width20 * 2.5,
                    top: Dimension.height10,
                    bottom: Dimension.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconSize: Dimension.iconSize24,
                        icon: Icons.remove,
                        backgroungColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    BigText(
                      text: 'N ${recommendedfood.products!.price} ' +
                          ' X ' +
                          ' ${controller.inCartItems} ',
                      color: AppColors.mainBlackColor,
                      size: Dimension.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        // print("Page id is " + recommendedfood.id.toString());
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        iconSize: Dimension.iconSize24,
                        icon: Icons.add,
                        backgroungColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Container(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimension.height20,
                          bottom: Dimension.height20,
                          right: Dimension.width20,
                          left: Dimension.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //print(recommendedfood..name);
                        controller.addItem(recommendedfood);
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: Dimension.height20,
                              bottom: Dimension.height20,
                              right: Dimension.width20,
                              left: Dimension.width20),
                          child: BigText(
                            text:
                                "\$${recommendedfood.products!.price} | Add to cart",
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                          )),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
