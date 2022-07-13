//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimension.pageViewContainer;

  @override
  void initState() {
    Get.find<PopularProductController>().getPopularProductList();
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final popularfood = Get.find<PopularProductController>().popularProductList;
    return Column(
      children: [
        // slider
        GetBuilder<PopularProductController>(builder: (popularproduct) {
          return GestureDetector(
            onTap: () => Get.toNamed(RouteHelper.popularFood),
            child: Container(
              //color: Colors.blueGrey,
              height: Dimension.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularproduct.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(
                        position, popularproduct.popularProductList[position]);
                  }),
            ),
          );
        }),

        // dots
        GetBuilder<PopularProductController>(builder: (popular) {
          return DotsIndicator(
            dotsCount: popular.popularProductList.isEmpty
                ? 1
                : popular.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        // popular
        SizedBox(
          height: Dimension.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(text: 'Popular'),
            SizedBox(
              width: Dimension.width10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: Dimension.height45 / 15),
              child: BigText(
                text: '.',
                color: Colors.black26,
              ),
            ),
            SizedBox(
              width: Dimension.width10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: Dimension.height10 / 5),
              child: SmallText(text: 'Food pairing'),
            ),
          ]),
        ),
        // List of food and images

        GetBuilder<RecommendedFoodController>(builder: (recommendedFood) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendedFood.recommendedProductList.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(
                  left: Dimension.width20,
                  right: Dimension.width20,
                  bottom: Dimension.height10),
              child: Row(
                children: [
                  // Image section
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.recommendedFood),
                    child: Container(
                      height: Dimension.listViewImgSize,
                      width: Dimension.listViewImgSize,
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                AppConstants.RECOMMENDED_FOOD_IMAGE +
                                    recommendedFood
                                        .recommendedProductList[index].img!),
                          )),
                    ),
                  ),

                  //Text Section
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProductList) {
    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimension.pageViewContainer,
            margin: EdgeInsets.symmetric(horizontal: Dimension.width10),
            decoration: BoxDecoration(
                color: index.isEven ? Color(0xFF696fac) : Color(0xFF696fcc),
                borderRadius: BorderRadius.circular(Dimension.raduis30),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.POPULAR_FOOD_IMAGE +
                        popularProductList.img!))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimension.width30,
                  right: Dimension.width30,
                  bottom: Dimension.height25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  boxShadow: [
                    BoxShadow(color: Color(0xFFe8e8e8), offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(5, 0)),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimension.height10,
                  right: Dimension.width10,
                  left: Dimension.width15,
                ),
                child: AppColumn(
                  text: popularProductList.name!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
