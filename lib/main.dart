import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/pages/auth/signin_screen.dart';
import 'package:food_delivery/pages/auth/signup_screen.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popualar_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';

import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_screen.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedFoodController>(builder: (_) {
        return GetBuilder<CartController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                primaryColor: AppColors.mainColor, fontFamily: "Lato"),
            // home: SignInScreen(),
            //const HomePage(),
            //     MainFoodPage(),
            initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
            // part 2 6:12 -- screen of admin backend
            // part 2 6:18 -- api versioning
            // 9:31 auth back
            // 1:43
            // Throughout the application process and in your career, keep blessing God. When things seem slow or are not working, keep blessing God. Bless God that you are the salt of the earth, bless God that you are the light of the world, bless God you are a city set on an hill that cannot be hidden. Psalm 34. Ensure you transfer this to your vn
          );
        });
      });
    });
  }
}
