class ProductModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? stars;
  String? img;
  String? location;
  String? createdAt;
  String? typeId;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.stars,
      required this.img,
      required this.location,
      required this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    typeId = json['typeId'];
  }
}
