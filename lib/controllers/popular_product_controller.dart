import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/product_model.dart';
import 'package:food_delivery/models/product.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'dart:ui';

class PopularProductController extends GetxController {
  PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  CartController? _cart;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItems => _inCartItems + _quantity; // 1
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    //print('yea');
    try {
      Response response = await popularProductRepo.GetPopularProductList();
      //print(response.body);
      //final extract = response.body as Map<String, dynamic>;
      //print(extract);
      // print(extract['data']);
      // final extractedData = extract['data'] as List;
      // print(extractedData);
      if (response.statusCode == 200) {
        // print('got hreee');
        _popularProductList = [];
        // print('in popular food' + Data.fromJson(response.body).toString());
        _popularProductList.addAll(Product.fromJson(response.body).data);
        // var data = ProductData.fromJson(response.body);
        // print('here is ' + Product.fromJson(response.body).data.toString());
        //  print('in popular food ' + data.product!.location.toString());
        _popularProductList.forEach((element) {});
        // extractedData.forEach((
        //   element,
        // ) {
        //   // print('The IMAGE' + element['products']['image']);
        //   _popularProductList.add(ProductModel(
        //       id: element['products']['id'] ?? 6,
        //       name: element['products']['name'] ?? 'name',
        //       description:
        //           element['products']['description'] ?? 'Any descriptiion',
        //       price: element['products']['price'] ?? "600",
        //       stars: element['products']['stars'] ?? '6',
        //       img: element['products']['image'] ??
        //           "https://media.istockphoto.com/photos/food-backgrounds-table-filled-with-large-variety-of-food-picture-id1155240408?k=20&m=1155240408&s=612x612&w=0&h=Zvr3TwVQ-wlfBnvGrgJCtv-_P_LUcIK301rCygnirbk=",
        //       location: element['products']['location'] ?? 'Anywhere',
        //       typeId: element['product_id'] ?? '2'));
        // });

        // print(_popularProductList);
        // print('empty' + _popularProductList.last.name!);
        _isLoaded = true;
        update();
        // print('Working');
      }
    } catch (e) {
      print('popular food error ' + e.toString());
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print('number of items  ' + _quantity.toString());
      // print('this is in_cart items ' + inCartItems.toString());
      // print('this is in cart items ' + _inCartItems.toString());
      // print('this is _quantity items ' + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print('number of items ' + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item Count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );

      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "Item Count",
        "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    //
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = cart.existIncart(product);
    // print('Exist or not : ' + exist.toString());
    if (exist) {
      _inCartItems = _cart!.getQuantity(product);
    }
    // print('The quantity in the cart is ' + _inCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cart!.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart!.getQuantity(product);
    //print(_inCartItems.toString() + ' total items added to cart');

    // _cart!.items.forEach((key, value) {
    //   print('The id is ' +
    //       value.id.toString() +
    //       ' and the quantity is ' +
    //       value.quantity.toString());
    // });

    update();
  }

  int get totalItems {
    return _cart!.totalItems;
  }

  List<CartModel> get getItems {
    return _cart!.getItems;
  }
}
