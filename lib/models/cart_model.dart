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

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "quantity": this.quantity,
      "isExist": this.isExist,
      "time": this.time,
    };
  }
}
