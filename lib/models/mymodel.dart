import 'dart:io';

var myMap = {
  'name': 'Peter',
  'age': 32,
  'city': 'Edo',
  'address': [
    {'Country': 'Nigeria', 'City': 'Benin'},
    {'Country': 'Benin', 'City': 'Bonu'}
  ],
};
// accessing the map above
// print(myMap['name']);
// print(myMapp['address']);

// accessing the inner list i.e the map in address

// var addressList = myMap['address'];

// (addressList as List).forEach((e){
//   print(e['country']);
// });

class Person {
  String? name;
  int? age;
  String? city;
  List<Address>? address;

  Person({required this.name, this.age, this.city, required this.address});

  Person.fromJson(Map<String, dynamic> json) {
    name = json['Country'];
    age = json['age'];
    city = json['city'];
    if (json['address'] != null) {
      address = <Address>[];
      (json['address'] as List).forEach((e) {
        address!.add(Address.fromJson(e));
      });
    }
  }
}

class Address {
  String? country;
  String? city;

  Address({required this.country, required this.city});
  Address.fromJson(Map<String, dynamic> json) {
    country = json['name'];
    city = json['city'];
  }
}

var obj = Person.fromJson(myMap);

var myAddress = obj.address;

// myAddress!.map((e){
// print();
// }).toList();
