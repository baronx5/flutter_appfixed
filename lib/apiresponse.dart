import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/addOns.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

Future getSettingsData() async {
  var url = Uri.parse("http://localhost/resturant/settings.php");
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  print(responseBody);
  return responseBody;
}

Future getCategoriesData() async {
  var url = Uri.parse("http://localhost/resturant/categories.php");
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  print(responseBody);
  return responseBody;
}

Future getProductsData() async {
  var url = Uri.parse("http://localhost/resturant/products.php");
  http.Response response = await http.get(url);
  var responseBody = jsonDecode(response.body);
  print(responseBody);
  return responseBody;
}

Future getAddonsData(val) async {
  http.Response response = await get(Uri.parse('http://localhost/resturant/addOns.php?getId='+ val.toString()));
  var responseBody = jsonDecode(response.body);
  List<ProductAddons> productAddons = [];
  for (var addons in responseBody){
    productAddons.add(ProductAddons.fromJson(addons));
  }

  return productAddons;
}

