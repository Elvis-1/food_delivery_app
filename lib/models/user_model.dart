class UserInfoModel {
  int id;
  String email;
  String name;
  String phone;
  int orderCount;

  UserInfoModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.orderCount});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
        id: json['id'] ?? 2,
        email: json['email'] ?? 'email@email.com',
        name: json['name'] ?? 'name',
        phone: json['phone'] ?? '88484848',
        orderCount: json['orderCount'] ?? 0);
  }
}
