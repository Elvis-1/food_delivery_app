import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  void addItem(ProductModel product, int quantity) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            stars: value.stars,
            img: value.img,
            isExist: true,
            quantity: value.quantity! + quantity,
            time: DateTime.now().toString());
      });
    } else {
      _items.putIfAbsent(product.id!, () {
        // _items.forEach((key, value) {
        //   print('The quantity of product added is ' + value.quantity.toString());
        // });
        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            stars: product.stars,
            img: product.img,
            isExist: true,
            quantity: quantity,
            time: DateTime.now().toString());
      });
    }
  }
}
