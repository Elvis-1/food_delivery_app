import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkerApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSigninScreen());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
