class User {
  int id;
  String name;
  String phone;
  String email;
  Address address;

  User({this.id, this.phone, this.name, this.email, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    if (json['address'] != null) {
      address = Address.fromJson(json['address']);
    } else {
      address = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    } else {
      address = null;
    }
    return data;
  }
}

class Address {
  int id;
  String area;
  String block;
  String street;
  String jada;
  String floor;
  String houseNumber;
  String userId;
  bool userDefault;

  Address(
      {this.id,
      this.area,
      this.block,
      this.street,
      this.jada,
      this.floor,
      this.houseNumber,
      this.userId,
        this.userDefault});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'].toString();
    block = json['block'].toString();
    street = json['street'].toString();
    jada = json['jada'].toString();
    floor = json['floor'].toString();
    houseNumber = json['housenumber'].toString();
    userId = json['userId'].toString();
    userDefault = json['user_default'] == "False" ? false : true;
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
    data['userId'] = this.userId;
    data['user_default'] = this.userDefault;
    return data;
  }

}
