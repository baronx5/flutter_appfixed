import 'package:flutter_appfixed/Models/product.dart';
class Item {
  int quantity;
  Product productItem;
  Item({this.productItem, this.quantity});

  double get getTotalItemPrice{
    double price = productItem.getTotalPrice * quantity;

   return price;
  }



}
