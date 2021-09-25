import 'dart:convert';
import 'package:flutter_appfixed/Models/cartItem.dart';
import 'package:flutter_appfixed/Models/user.dart';


class Order {
  int id;
  User user;
  List<Item> orderItems = [];
  String level;

  Order({this.id, this.user, this.orderItems, this.level});

  Order.fromJson(Map<String, dynamic> json){
    var orderDetails = jsonDecode(json['order_details']);
    id = json['id'];
    level = json['level'];
    user = User.fromJson(orderDetails['user']);
    orderDetails['orders'].forEach((item) => orderItems.add(Item.fromJson(item)));
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

  Map<String, dynamic> toFirebaseJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = user.toFirebaseJson();
    data['orders'] = orderItems.map((v) => v.toJson()).toList();
    data['level'] = level;
    return data;
  }

}