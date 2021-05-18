import 'package:flutter/material.dart';
import 'Models/cartItem.dart';
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
// String apiUrl = "http://10.0.2.2:5000/";
// String apiUrl = "http://127.0.0.1:5000/";
 String apiUrl = "https://fake-api-kuwait.herokuapp.com/";

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

savePref(User user) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('user', jsonEncode(user.toJson()));
}

Future signIn(String phone, String password, BuildContext context) async {
  var data = {"phone": phone, "password": password};
  var url = apiUrl + 'login';
  var response = await http.post(Uri.parse(url), body: data);
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == "success") {
    User user = User.fromJson(responseBody['data']);
    savePref(user);
    return Navigator.pushReplacementNamed(context, 'MyApp', arguments: user);
  } else {
    print(responseBody['msg']);
    return responseBody['msg'];
  }
}

Future signUp(
    String phone, String password, String email, BuildContext context) async {
  var data = {"phone": phone, "password": password, "email": email};
  var url = apiUrl + '/signUp';
  var response = await http.post(Uri.parse(url), body: data);
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == 'success') {
    print('new account has been created');
    return responseBody['msg'];
  } else {
    return responseBody['msg'];
  }
}

Future placeOrder(User user, List<Item> orders, BuildContext context) async {
  var data = {"user": user.toJson(), "orders": orders};
  var response = await http
      .post(Uri.parse(apiUrl + 'order'), body: jsonEncode(data), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == 'success') {
    print('Order accepted');
    return responseBody['msg'];
  } else {
    print('Order denied');
    return responseBody['msg'];
  }
}

Future newAddress(User user, BuildContext context) async {
  var data = {"address": user.address.toJson()};
  var url = apiUrl + 'address/add/';
  var response = await http.post(Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json; charset=UTF-8'});
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == 'success') {
    return responseBody;
  } else {
    return responseBody;
  }
}
Future<List<Address>> getAddressData(int val) async {
  var url = Uri.parse(apiUrl + "address/" + val.toString());
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  print('dfsdfsdfsdfsdfsdfsdfsdfsdf');
  List<Address> address = [];
  for (var adr in responseBody) {
    address.add(Address.fromJson(adr));
  }
  return address;
}


Future addressUpdate(Address address, BuildContext context) async {
  var data = {"address": address.toJson()};
  var url = apiUrl + 'address/edit/';
  var response = await http.post(Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json; charset=UTF-8'});
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == 'success') {
    return responseBody;
  } else {
    return responseBody;
  }
}
Future addressRemove(Address address) async {
  var data = {"address": address.toJson()};
  var url = apiUrl + 'address/remove/';
  var response = await http.post(Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json; charset=UTF-8'});
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == 'success') {
    return responseBody;
  } else {
    return responseBody;
  }
}