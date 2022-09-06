class UserModel {
  int id;
  String email;
  String name;
  String phone;
  int orderCount;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.orderCount});
}
