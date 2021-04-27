import 'package:flutter_appfixed/Models/addOns.dart';

class Product {
  int id;
  String name;
  String description;
  String image;
  double price;
  String catId;
  int totalSales;
  List<ProductAddons> addons;

  Product(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.price,
      this.catId,
      this.totalSales,
      this.addons}) {
    if (this.addons == null) {
      this.addons = [];
    }
  }

  Product.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = double.parse(json['price']);
    catId = json['catId'];
    totalSales = int.parse(json['totalSales']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['catId'] = this.catId;
    data['totalSales'] = this.totalSales;
    return data;
  }

  double get getAddonsPrice {
    double price = 0;
    price += this.price;
    if (addons.length > 0) {
      for (var addon in addons) {
        price += addon.price;
      }
    }
    return price;
  }
}
