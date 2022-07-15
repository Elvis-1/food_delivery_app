import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/app_icon.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendedfood =
        Get.find<RecommendedFoodController>().recommendedProductList[pageId];
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
                      onTap: () => Get.back(),
                      child: AppIcon(icon: Icons.clear)),
                  AppIcon(icon: Icons.shopping_cart_outlined),
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
                          size: Dimension.font26, text: recommendedfood.name!)),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.RECOMMENDED_FOOD_IMAGE + recommendedfood.img!,
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
                      text: recommendedfood.description!,
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
                      AppIcon(
                        icon: Icons.remove,
                        backgroungColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimension.iconSize24,
                      ),
                      BigText(
                        text: '\$12.88 ' + ' X ' + ' 0 ',
                        color: AppColors.mainBlackColor,
                        size: Dimension.font26,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('I am tapped');
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
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: Dimension.height20,
                              bottom: Dimension.height20,
                              right: Dimension.width20,
                              left: Dimension.width20),
                          child: BigText(
                            text: "\$10 | Add to cart",
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20),
                          )),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
