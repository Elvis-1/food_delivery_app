import 'package:flutter/cupertino.dart';
import 'package:food_delivery/pages/address/add_address_screen.dart';
import 'package:food_delivery/pages/address/pick_address_map.dart';
import 'package:food_delivery/pages/auth/signin_screen.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popualar_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const initial = '/';
  static const splashScreen = '/splash-screen';
  static const popularFood = '/popular-food';
  static const recommendedFood = '/recommended-food';
  static const cartPage = '/cart-page';
  static const siginPage = '/sign-in';

  static const addAddress = '/add-address';
  static const pickAddressMap = '/pick-addrress-map';

  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getSplashScreen() => '$splashScreen';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getInitial() => '$initial';
  static String getCartPage() => '$cartPage';
  static String getSigninScreen() => '$siginPage';
  static String getAddAddressScreen() => '$addAddress';

  static String getPickAddressMapScreen() => '$pickAddressMap';

  static List<GetPage> routes = [
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddressMap = Get.arguments;
          return _pickAddressMap;
        }),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        //print('This is ' + pageId.toString());
        return PopuparFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        }),
    GetPage(
        name: siginPage,
        page: () {
          return SignInScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressScreen();
        },
        transition: Transition.circularReveal)
  ];
}
