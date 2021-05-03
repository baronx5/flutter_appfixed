import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/categories.dart';
import 'package:flutter_appfixed/Models/product.dart';
import 'package:flutter_appfixed/Models/addOns.dart';
import 'package:flutter_appfixed/Models/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Url https://flutterforweb.000webhostapp.com/
String apiUrl = "http://localhost/resturant/";

Future getSettingsData() async {
  var url = Uri.parse(apiUrl + "settings.php");
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  List<Settings> settings = [];
  for (var set in responseBody) {
    settings.add(Settings.fromJson(set));
  }
  return settings;
}

Future getCategoriesData() async {
  var url = Uri.parse(apiUrl + "categories.php");
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  List<Categories> categories = [];
  for (var cat in responseBody) {
    categories.add(Categories.fromJson(cat));
  }
  return categories;
}

Future getProductsData(val) async {
  var url = Uri.parse(apiUrl + "products.php?getId=" + val.toString());
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  List<Product> products = [];
  for (var product in responseBody) {
    products.add(Product.fromJson(product));
  }
  return products;
}

Future getBestSalesData() async {
  var url = Uri.parse(apiUrl + "bestSales.php");
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
      await get(Uri.parse(apiUrl + "addOns.php?getId=" + val.toString()));
  var responseBody = jsonDecode(response.body);
  List<ProductAddons> productAddons = [];
  for (var addons in responseBody) {
    productAddons.add(ProductAddons.fromJson(addons));
  }

  return productAddons;
}



savePref(String name, String email) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('name', name);
  preferences.setString('email', email);
}


Future signIn(String phone, String password, BuildContext context) async {
  var data = {"phone": phone, "password": password};
  var url = 'http://localhost/resturant/login/authenticate.php';
  var response = await http.post(Uri.parse(url), body: data);
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == "success") {
    User user = User(id: responseBody['id'], name: responseBody['name']);
    savePref(responseBody['name'], responseBody['email']);
    return Navigator.pushReplacementNamed(context, 'MyApp', arguments: user);
  } else {
    print(responseBody['msg']);
    return responseBody['msg'];
  }
}


Future signUp(String phone, String password,String email, BuildContext context) async {
  var data = {"phone": phone, "password": password, "email": email};
  var url = 'http://localhost/resturant/login/register.php';
  var response = await http.post(Uri.parse(url), body: data);
  var responseBody = jsonDecode(response.body);
  if(responseBody['status'] == 'success'){
    print('hfrfr');
    return responseBody['msg'];
  }else {
    return responseBody['msg'];
  }
}