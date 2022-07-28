import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartlist) {
    // since this method will be called many times, set cart to empty first
    cart = [];
    /*
 convert object to string because sharedpreferences only accept string
    */
    cartlist.forEach((element) {
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList('Cart-List', cart);
    print(sharedPreferences.getStringList('Cart-List'));
  }
}
