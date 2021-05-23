import 'package:flutter_appfixed/Models/cartItem.dart';
import 'package:flutter_appfixed/Models/user.dart';


class Order {
  int id;
  User user;
  List<Item> orderItems = [];
  String level;

  Order({this.id, this.user, this.orderItems, this.level});

  Order.fromJson(Map<String, dynamic> json){
    id = json['id'];
    user = User.fromJson(json['user']);
    json['orders'].forEach((item) => orderItems.add(Item.fromJson(item)));
    level = json['level'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user'] = user.toJson();
    data['orders'] = orderItems.map((v) => v.toJson()).toList();
    data['level'] = level;
    return data;
  }

  List<Map<String, dynamic>> orderItemsToJson(List<Item> orderItems) {
    List<Map<String, dynamic>> data = [];
    orderItems.map((order) => data.add(order.toJson()));
    return data;
  }

}