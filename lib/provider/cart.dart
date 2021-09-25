import 'package:firebase_auth/firebase_auth.dart' as _auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter_appfixed/Models/cartItem.dart';
import 'package:flutter_appfixed/Models/user.dart';

class Carts extends ChangeNotifier {
  List<Item> _items = [];
  double _totalPrice = 0.0;
  User user;
  bool isSignedIn = false;

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

  void saveUserInProvider(User user){
    this.user = user;
    this.isSignedIn = true;
    notifyListeners();
  }

  void logOutUserInProvider(){
    this.user = null;
    this.isSignedIn = false;
    notifyListeners();
  }

  void removeUserAddressProvider(Address address){
    user.address.remove(address);
    notifyListeners();
  }

  void addUserAddressProvider(Address address){
    user.address.add(address);
    notifyListeners();
  }

  void updateUserAddressProvider(int addressIndex, Address address){
    user.address[addressIndex] = address;
    notifyListeners();
  }

}
