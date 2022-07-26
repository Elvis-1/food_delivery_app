import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class PopuparFoodDetail extends StatelessWidget {
  int pageId;
  PopuparFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    // print("Page id is " + pageId.toString());
    // print("product of id is " + product.id.toString());
    // Get.find<PopularProductController>()
    //     .initProduct(Get.find<CartController>());
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    Get.find<PopularProductController>().getPopularProductList();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // background image
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: Dimension.popularFoodContainer,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              AppConstants.POPULAR_FOOD_IMAGE + product.img!))),
                )),

            // icon widget
            Positioned(
                top: Dimension.height45,
                left: Dimension.width20,
                right: Dimension.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios),
                    ),
                    GetBuilder<PopularProductController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems > 1)
                            Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            Get.find<PopularProductController>().totalItems >= 1
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
                )),

            // introduction to food
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
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimension.radius20),
                            topLeft: Radius.circular(Dimension.radius20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColumn(text: product.name!),
                        SizedBox(
                          height: Dimension.height20,
                        ),
                        BigText(text: 'Introduce'),
                        SizedBox(
                          height: Dimension.height20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text: product.description!),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (pupularProduct) {
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
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pupularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      BigText(text: pupularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimension.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          pupularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // print(product.name);
                    pupularProduct.addItem(product);
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          top: Dimension.height20,
                          bottom: Dimension.height20,
                          right: Dimension.width20,
                          left: Dimension.width20),
                      child: BigText(
                        text: "N ${product.price} | Add to cart",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                      )),
                )
              ],
            ),
          );
        }));
  }
}
