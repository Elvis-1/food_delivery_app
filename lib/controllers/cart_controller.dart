import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartController extends GetxController {
  CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    print(product.name! + ' from cart controller');
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            stars: value.stars,
            img: value.img,
            isExist: true,
            quantity: value.quantity! + quantity,
            time: DateTime.now().toString(),
            product: product);
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
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
              time: DateTime.now().toString(),
              product: product);
        });
      } else {
        Get.snackbar(
          "Item Count",
          "You should at least add one item to the cart!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }

    update();
  }

  bool existIncart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
}
