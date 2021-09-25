import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'Models/categories.dart';
import 'Models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appfixed/Models/order.dart';

// Url https://flutterforweb.000webhostapp.com/
// String apiUrl = "http://10.0.2.2:5000/";
//  String apiUrl = "http://127.0.0.1:6000/";
String apiUrl = "https://fake-api-kuwait.herokuapp.com/";

final CollectionReference _categoriesCollection =
    FirebaseFirestore.instance.collection('categories');

final CollectionReference _productsCollection =
    FirebaseFirestore.instance.collection('products');

final CollectionReference _ordersCollection =
    FirebaseFirestore.instance.collection('orders');

final CollectionReference _usersCollection =
    FirebaseFirestore.instance.collection('users');

final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

// Future getSettingsData() async {
//   var url = Uri.parse(apiUrl + "settings");
//   http.Response response = await http.get(url);
//   var responseBody = jsonDecode(response.body);
//   List<Settings> settings = [];
//   for (var set in responseBody) {
//     settings.add(Settings.fromJson(set));
//   }
//   return settings;
// }

Future<List<Categories>> getCategoriesData() async {
  return await _categoriesCollection.get().then((value) =>
      value.docs.map((e) => Categories.fromFirebase(e.data(), e.id)).toList());
}

Future<List<Product>> getProductByCatId(val) async {
  return await _productsCollection.where('catId', isEqualTo: val).get().then(
      (value) => value.docs
          .map((item) => Product.fromFirebase(item.data(), item.id))
          .toList());
}

Future<List<Product>> getBestSalesData() async {
  return await _productsCollection
      .where('totalSales', isGreaterThan: 0)
      .get()
      .then((value) => value.docs
          .map((item) => Product.fromFirebase(item.data(), item.id))
          .toList());
}

Future<User> signIn(String email, String password) async {
  User user = await _auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((firebaseResponse) => _usersCollection
          .doc(firebaseResponse.user.uid)
          .get()
          .then((document) => User.fromFirebaseJson(document.data(),
              firebaseResponse.user.uid, firebaseResponse.user.email)));
  return user;
}

Future signUp(String phone, String password, String name, String email,
    BuildContext context) async {
  Map<String, dynamic> user = {
    'phone': phone,
    'name': name,
    'address': []
  };
  return await _auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => _usersCollection.doc(value.user.uid).set(user));
}

Future<Order> placeOrder(Order order, BuildContext context) async {
  order.level = 'new';
  return await _ordersCollection
      .doc()
      .set(order.toFirebaseJson())
      .then((value) => order);
}

// Future<Order> getOrderLevelData(int val) async {
//   var url = Uri.parse(apiUrl + "order/" + val.toString());
//   http.Response response = await http.get(url);
//   var responseBody = jsonDecode(response.body);
//   Order order = Order.fromJson(responseBody['data']);
//   return order;
// }

Future<List<Order>> getUserPendingOrders(String userId) async {
  return await _ordersCollection.where('userId', isEqualTo: userId).get().then(
          (value) => value.docs
          .map((item) => Order.fromFirebaseJson(item.data(), item.id))
          .toList());
}

Future<void> newAddress(User user, Address address) async {
  user.address.forEach((e) {
    if(e.userDefault == true && e != address){
      e.userDefault = false;
    }else if(e == address){
      e.userDefault = true;
    }
  });

  return await _usersCollection
      .doc(user.id)
      .set({'address': user.address.map((item) => item.toFirebaseJson()).toList()}, SetOptions(merge: true));
}

Future<void> addressUpdate(User user, Address address) async {
  user.address.forEach((e) {
    if(e.userDefault == true && e != address){
      e.userDefault = false;
    }else if(e == address){
      e.userDefault = true;
    }
  });
  return await _usersCollection.doc(user.id).update({'address': user.address.map((e) => e.toFirebaseJson()).toList()});
}

Future<void> addressRemove(Address address, User user) async {
  return await _usersCollection.doc(user.id).update({'address': user.address.map((e) => e.toFirebaseJson()).toList()});
}
