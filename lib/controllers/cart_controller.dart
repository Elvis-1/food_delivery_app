import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> items = {};

  void addItem(ProductModel product, int quantity) {
    items.putIfAbsent(
        product.id!,
        () => CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            stars: product.stars,
            img: product.img,
            isExist: true,
            quantity: quantity,
            time: DateTime.now().toString()));
  }
}
