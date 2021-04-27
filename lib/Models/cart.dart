import 'package:flutter/cupertino.dart';
import 'package:flutter_appfixed/Models/cartItem.dart';

class Carts extends ChangeNotifier {

  List<Item> _items = [];
  double _totalPrice = 0.0;

  void add(Item item){
    _items.add(item);
    _totalPrice += item.productItem.price;
    if(item.productItem.addons.length > 0){
      for(var addon in item.productItem.addons){
        _totalPrice += addon.price;
      }
    }
    notifyListeners();
  }

  void remove(Item item){
    _items.remove(item);
    _totalPrice -= item.productItem.price;
    if(item.productItem.addons.length > 0) {
      for (var addon in item.productItem.addons) {
        _totalPrice -= addon.price;
      }
    }
    notifyListeners();
  }

  int get count{
    return _items.length;
  }

  double get totalPrice{
    return _totalPrice;
  }

  List<Item> get basketItems{
    return _items;
  }
}