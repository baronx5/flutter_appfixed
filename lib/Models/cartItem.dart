import 'package:flutter_appfixed/Models/product.dart';

class Item {
  int quantity;
  Product productItem;

  Item({this.productItem, this.quantity});

  double get getTotalItemPrice {
    double price = productItem.getTotalPrice * quantity;

    return price;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['productItem'] = this.productItem.toJson();
    return data;
  }

  Item.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productItem = Product.fromJson(json['productItem']);
  }

  Map<String, dynamic> toFirebaseJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['productItem'] = this.productItem.toFirebaseJson();
    return data;
  }
}
