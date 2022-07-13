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
}
