import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  CartController({required this.cartRepo});
}
