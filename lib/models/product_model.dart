class Product {
  late List<ProductModel> _data;
  List<ProductModel> get data => _data;

  Product({required data}) {
    this._data = data;
  }

  Product.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <ProductModel>[];
      json['data'].forEach((v) {
        _data.add(ProductModel.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.data != null) {
  //     data['data'] = this.data.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class ProductModel {
  int? productType;
  Products? products;
  ProductModel({required productType, required products}) {
    this.productType = productType;
    this.products = products;
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    productType = json['product_type'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_type'] = this.productType;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  String? price;
  String? stars;
  String? image;
  String? location;

  Products(
      {required id,
      required name,
      required description,
      required price,
      required stars,
      required image,
      required location}) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.image = image;
    this.price = price;
    this.location = location;
    this.stars = stars;
  }

  Products.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.description = json['description'];
    this.price = json['price'];
    this.stars = json['stars'];
    this.image = json['image'];
    this.location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stars'] = this.stars;
    data['image'] = this.image;
    data['location'] = this.location;
    return data;
  }
}
