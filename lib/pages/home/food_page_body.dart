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
    // Get.find<PopularProductController>().getPopularProductList();
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
    //final popularfood = Get.find<PopularProductController>().popularProductList;
    return Column(
      children: [
        // slider
        GetBuilder<RecommendedFoodController>(builder: (recommended) {
          return recommended.isLoaded
              ? GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.recommendedFood),
                  child: Container(
                    //color: Colors.blueGrey,
                    height: Dimension.pageView,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: recommended.recommendedProductList.length,
                        itemBuilder: (context, position) {
                          return _buildPageItem(position,
                              recommended.recommendedProductList[position]);
                        }),
                  ),
                )
              : Container(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }),

        // dots
        GetBuilder<RecommendedFoodController>(builder: (recommended) {
          return DotsIndicator(
            dotsCount: recommended.recommendedProductList.isEmpty
                ? 1
                : recommended.recommendedProductList.length,
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

        GetBuilder<PopularProductController>(builder: (popularfood) {
          return popularfood.isLoaded
              ? GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.popularFood),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: popularfood.popularProductList.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(
                          left: Dimension.width20,
                          right: Dimension.width20,
                          bottom: Dimension.height10),
                      child: Row(
                        children: [
                          // Image section

                          Container(
                            height: Dimension.listViewImgSize,
                            width: Dimension.listViewImgSize,
                            decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius:
                                    BorderRadius.circular(Dimension.radius20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.POPULAR_FOOD_IMAGE +
                                          popularfood
                                              .popularProductList[index].img!),
                                )),
                          ),

                          //Text Section

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
                                  borderRadius:
                                      BorderRadius.circular(Dimension.radius20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFFe8e8e8),
                                        offset: Offset(0, 5)),
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-5, 0)),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                        text: popularfood
                                            .popularProductList[index].name!,
                                        size: Dimension.font26,
                                      ),
                                      SizedBox(
                                        height: Dimension.height20 / 10,
                                      ),
                                      Row(
                                        children: [
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
                                      // SizedBox(
                                      //   height: Dimension.height20,
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                  )),
                            ),
                          )
                          // IconAndTextWidget(
                          //     icon: icon, text: text, iconColor: iconColor)
                        ],
                      ),
                    ),
                  ))
              : Container(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel recommended) {
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
                    image: NetworkImage(AppConstants.RECOMMENDED_FOOD_IMAGE +
                        recommended.img!))),
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
                  text: recommended.name!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
