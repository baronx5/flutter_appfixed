import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_appfixed/address/ViewAllAddress.dart';
import 'package:flutter_appfixed/address/address.dart';
import 'Models/cartItem.dart';
import 'Models/cart.dart';
import 'Models/user.dart';
import 'apiResponse.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOut extends StatefulWidget {
  List<Item> orderItems = [];

  CheckOut({@required this.orderItems});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  double totalPrice = 0;
  bool isSignIn = false;
  User user;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user') != null) {
      setState(() {
        user = User.fromJson(jsonDecode(preferences.getString('user')));
        isSignIn = true;
      });
    }
  }

  refresh() async {
    print("checkout refresh function invoked");
    getPref();
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'خطوات اكمال الطلب',
            style: TextStyle(
                fontSize: 18, fontFamily: 'Droid', color: Colors.black54),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black54),
        ),
        body: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Column(
                  children: [
                    Image.network(
                      'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg',
                      fit: BoxFit.cover,
                    ),
                    isSignIn == true && user.address != null
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.orangeAccent,
                                  size: 33,
                                ),
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      user.address.area,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Droid',
                                          color: Colors.grey),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          user.address.houseNumber,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          'شقة',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          user.address.floor,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          'دور',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          user.address.houseNumber,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          'منزل',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          user.address.jada,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          'جادة',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          user.address.street,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          'شارع',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          user.address.block,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          'ق',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Droid',
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      child: Text(
                                        'تغيير',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Droid',
                                            color: Colors.orange),
                                      ),
                                      onTap: () {
                                        // Navigator.of(context).pushNamed(
                                        //     'viewaddress',
                                        //     arguments: user);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewAllAddress(notifyCheckoutPage: refresh, user: user)));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.orangeAccent,
                                  size: 33,
                                ),
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "لايوجد عنوان مسجل مسبقاً",
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'Droid'),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          primary: Colors.white),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 15),
                                          child: Center(
                                              child: Text(
                                            "اضف عنوان",
                                            style: TextStyle(
                                                fontFamily: 'Droid',
                                                fontSize: 16),
                                          ))),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddAddress(
                                                  notifyCheckoutPage: refresh)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
              Divider(),
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                      ),
                    ),
                    Text('مدة التوصيل 60 دقيقة',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Droid',
                          color: Colors.white,
                        )),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.orange[400]),
              ),
              Divider(),
              Column(
                children: [
                  Text('ملخص الدفع',
                      style: TextStyle(fontSize: 18, fontFamily: 'Droid')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(' طلب  ',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                          Text(widget.orderItems.length.toString(),
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                      Text('مجموع الطلبات',
                          style: TextStyle(fontSize: 14, fontFamily: 'Droid')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(' دك  ',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                          Text('0.5',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                      Text('رسوم التوصيل',
                          style: TextStyle(fontSize: 14, fontFamily: 'Droid')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(' دك  ',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                          Text(cart.totalPrice.toString(),
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                      Text('المبلغ الاجمالي',
                          style: TextStyle(fontSize: 14, fontFamily: 'Droid')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
          height: 100,
          color: Colors.grey[200],
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: null,
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              placeOrder(user, cart.basketItems, context);
            },
            child: Text(
              'تنفيذ الطلب',
              style: TextStyle(fontFamily: 'Droid', fontSize: 18),
            ),
          ),
        ),
      );
    });
  }
}
