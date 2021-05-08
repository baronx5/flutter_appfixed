import 'dart:convert';

class User{
  int id;
  String name;
  String email;
  Address address;

  User({this.id,this.name, this.email, this.address});


  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = Address.fromJson(json['address']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address.toJson();
    return data;
  }

}
class Address{
  int id;
  String area;
  String block;
  String street;
  String jada;
  String floor;
  String houseNumber;
  String userId;

  Address(
      {this.id,
      this.area,
      this.block,
      this.street,
      this.jada,
      this.floor,
      this.houseNumber,
      this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'].toString();
    block = json['block'].toString();
    street = json['street'].toString();
    jada = json['jada'].toString();
    floor = json['floor'].toString();
    houseNumber = json['housenumber'].toString();
    userId = json['userId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area'] = this.area;
    data['block'] = this.block;
    data['street'] = this.street;
    data['jada'] = this.jada;
    data['floor'] = this.floor;
    data['housenumber'] = this.houseNumber;
    data['userId'] = userId;
    return data;
  }


}