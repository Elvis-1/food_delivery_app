import 'package:food_delivery/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  String? time;
  int? quantity;
  bool? isExist;
  String? price;
  String? stars;
  String? img;
  ProductModel? product;

  CartModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.stars,
      required this.img,
      required this.isExist,
      required this.quantity,
      required this.time,
      required this.product});
}
