import 'package:flutter/cupertino.dart';
import 'package:food_delivery/pages/food/popualar_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const initial = '/';
  static const popularFood = '/popular-food';
  static const recommendedFood = '/recommended-food';

  static String getPopularFood() => '$popularFood';
  static String getRecommendedFood() => '$recommendedFood';
  static String getInitial() => '$initial';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
      name: popularFood,
      page: () {
        return PopuparFoodDetail();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        return RecommendedFoodDetail();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
