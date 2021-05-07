import 'package:flutter/material.dart';
import 'Models/adress.dart';
import 'Models/categories.dart';
import 'Models/product.dart';
import 'Models/addOns.dart';
import 'Models/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Url https://flutterforweb.000webhostapp.com/
String apiUrl = "http://127.0.0.1:5000/";

Future getSettingsData() async {
  var url = Uri.parse(apiUrl + "settings");
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  List<Settings> settings = [];
  for (var set in responseBody) {
    settings.add(Settings.fromJson(set));
  }
  return settings;
}

Future getCategoriesData() async {
  var url = Uri.parse(apiUrl + "categories");
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  List<Categories> categories = [];
  for (var cat in responseBody) {
    categories.add(Categories.fromJson(cat));
  }
  return categories;
}

Future getProductsData(val) async {
  var url = Uri.parse(apiUrl + "products/" + val.toString());
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  List<Product> products = [];
  for (var product in responseBody) {
    products.add(Product.fromJson(product));
  }
  return products;
}

Future getBestSalesData() async {
  var url = Uri.parse(apiUrl + "best_sales");
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  List<Product> products = [];
  for (var product in responseBody) {
    products.add(Product.fromJson(product));
  }
  return products;
}

Future getAddonsData(val) async {
  http.Response response =
      await get(Uri.parse(apiUrl + "addons/" + val.toString()));
  var responseBody = jsonDecode(response.body);
  List<ProductAddons> productAddons = [];
  for (var addons in responseBody) {
    productAddons.add(ProductAddons.fromJson(addons));
  }

  return productAddons;
}



savePref(int uid,String email) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('id', uid);
  preferences.setString('email', email);
}




Future signIn(String phone, String password, BuildContext context) async {
  var data = {"phone": phone, "password": password};
  var url = apiUrl+'/login';
  var response = await http.post(Uri.parse(url), body: data);
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == "success") {
    User user = User(id: responseBody['id'], name: responseBody['name']);
    savePref(responseBody['data']['id'], responseBody['data']['email']);
    print(responseBody['data']['id']);
    return Navigator.pushReplacementNamed(context, 'MyApp', arguments: user);
  } else {
    print(responseBody['msg']);
    return responseBody['msg'];
  }
}


Future signUp(String phone, String password,String email, BuildContext context) async {
  var data = {"phone": phone, "password": password, "email": email};
  var url = apiUrl+ '/signUp';
  var response = await http.post(Uri.parse(url), body: data);
  var responseBody = jsonDecode(response.body);
  if(responseBody['status'] == 'success'){
    print('new account has been created');
    return responseBody['msg'];
  }else {
    return responseBody['msg'];
  }
}

Future placeOrder(String phone, String password,String email, BuildContext context) async {
  var data = {"phone": phone, "password": password, "email": email};
  var url = 'http://localhost/resturant/login/placeOrder.php';
  var response = await http.post(Uri.parse(url), body: data);
  var responseBody = jsonDecode(response.body);
  if(responseBody['status'] == 'success'){
    print('Order accepted');
    return responseBody['msg'];
  }else {
    print('Order denied');
    return responseBody['msg'];
  }
}


Future<List<dynamic>> getAdr(val) async {
  var url = Uri.parse(apiUrl +"adress/"+val.toString());
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  List<Adress> Adresses = [];
  for (var adr in responseBody) {
    Adresses.add(Adress.fromJson(adr));
  }
  return Adresses;
}

