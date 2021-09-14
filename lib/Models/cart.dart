import 'package:flutter/cupertino.dart';
import 'package:flutter_appfixed/Models/cartItem.dart';

class Carts extends ChangeNotifier {
  List<Item> _items = [];
  double _totalPrice = 0.0;

  void add(Item item) {
    _items.add(item);
    _totalPrice += item.getTotalItemPrice;
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    _totalPrice -= item.getTotalItemPrice;
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<Item> get basketItems {
    return _items;
  }

  void clearBasket(){
    _totalPrice = 0.0;
    _items.clear();
    notifyListeners();
  }
}
