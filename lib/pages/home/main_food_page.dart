import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';

import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_food_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedFoodController>().getRecommendedFoodList();
    Get.find<CartController>();
  }

  @override
  Widget build(BuildContext context) {
    // print('This is screen height ' +
    //     MediaQuery.of(context).size.height.toString());
    // print(
    //     'This is screen width ' + MediaQuery.of(context).size.width.toString());
    return RefreshIndicator(
        child: Column(
          children: [
            // showing the header
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimension.height45, bottom: Dimension.height15),
                padding: EdgeInsets.symmetric(horizontal: Dimension.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "Nigeria",
                          color: AppColors.mainColor,
                          size: Dimension.height30,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: 'Lagos',
                              color: Colors.black54,
                            ),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimension.height45,
                        height: Dimension.height45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // showing the body
            Expanded(
                child: SingleChildScrollView(
              child: FoodPageBody(),
            )),
          ],
        ),
        onRefresh: _loadResources);
  }
}
