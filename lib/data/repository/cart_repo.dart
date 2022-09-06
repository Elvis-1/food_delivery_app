import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartlist) {
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // return;
    var time = DateTime.now().toString();
    // since this method will be called many times, set cart to empty first
    cart = [];
    /*
 convert object to string because sharedpreferences only accept string
    */
    cartlist.forEach((element) {
      // setting time per order
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);

    // print(cart.toString() + 'this is cart in adtocartlist');
    //getCartList();
  }

  List<CartModel> getCartList() {
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST).toString() +
    //     'this is cart list');
    // our getCartList method is expecting a list of cartmodel, but sharedpref stored data as a string, so we get it as a string first
    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      // print("Inside get cartlis " + carts.toString());
    }
    List<CartModel> cartList = [];

    carts.forEach((element) {
      return cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    // print(carts.toString() + ' here');
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    // we can't return cartHistory because cartHistory is a list of string but our method needs to return a list of cartModel, so we have to convert the list of string into a list of cartmadel
    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) =>
        cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));

    return cartHistoryList;
  }

  void addToCartHistoryList() {
    // print('I am addToCartHistoryList');

    for (int i = 0; i < cart.length; i++) {
      // print("History list " + cart[i] + 'maybe empy');
      cartHistory.add(cart[i]);
    }
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      //print("History list " + cartHistory[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);

    // print("The length of history list is " +
    //     getCartHistoryList().length.toString());
    for (int i = 0; i < getCartHistoryList().length; i++) {
      // print("The time for the order is " +
      //     getCartHistoryList()[i].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() {
    removeCart();

    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
