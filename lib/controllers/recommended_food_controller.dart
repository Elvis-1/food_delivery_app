import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/recommended_food-repo.dart';
import 'package:food_delivery/models/product.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../models/product_model.dart';

class RecommendedFoodController extends GetxController {
  RecommendedFoodRepo recommendedFoodRepo;

  RecommendedFoodController({required this.recommendedFoodRepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int get inCartItems => _inCartItems + _quantity;

  Future<void> getRecommendedFoodList() async {
    try {
      Response response = await recommendedFoodRepo.GetRecommendedFoodList();
      // print(response.body);
      final extract = response.body as Map<String, dynamic>;
      // print(extract);
      // print(extract['data']);
      final extractedData = extract['data'] as List;
      // print(extractedData[0]['product_type']);
      // print('this is it ' + extractedData.toString());
      if (response.statusCode == 200) {
        _recommendedProductList = [];
        var pro = ProductModel.fromJson(response.body);
        //print(pro.data![0].product_type);
        // var data = ProductData.fromJson(response.body);

        // print('here is recom' + pro.data.toString());
        // print('The IMAGE' + element['products']['image']);
        _recommendedProductList.addAll(Product.fromJson(response.body).data);
        // print('hreee' + Product.fromJson(response.body).data.toString());
        _isLoaded = true;
        update();
        // ProductModel(
        //   id: element['products']['id'] ?? 5,
        //   name: element['products']['name'] ?? 'nmee',
        //   description: element['products']['description'] ?? "description",
        //   price: element['products']['price'] ?? '900',
        //   stars: element['products']['stars'] ?? '7',
        //   img: element['products']['image'] ??
        //       "https://media.istockphoto.com/photos/food-backgrounds-table-filled-with-large-variety-of-food-picture-id1155240408?k=20&m=1155240408&s=612x612&w=0&h=Zvr3TwVQ-wlfBnvGrgJCtv-_P_LUcIK301rCygnirbk=",
        //   location: element['products']['location'] ?? "location",
        //   typeId: element['product_id'] ?? '7'));

        //  }
      }
    } catch (e) {
      print('recommended food error ' + e.toString());
    }

    // print(_popularProductList);
    // print('empty' + _popularProductList.last.name!);

    // print('Working');
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print('increment ' + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print('decrement ' + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Item Count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > 20) {
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
    update();
  }

  void initProduct() {
    _quantity = 0;
    _inCartItems = 0;
  }
}
