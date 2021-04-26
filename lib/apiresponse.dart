import 'package:flutter_appfixed/Models/categories.dart';
import 'package:flutter_appfixed/Models/product.dart';
import 'package:flutter_appfixed/Models/addOns.dart';
import 'package:flutter_appfixed/Models/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

String apiUrl = "https://flutterforweb.000webhostapp.com/resturant/";

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

Future getProductsData() async {
  var url = Uri.parse(apiUrl + "products.php");
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
