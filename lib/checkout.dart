import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_appfixed/followUpOrder/followOrder.dart';
import 'address/ViewAllAddress.dart';
import 'address/address.dart';
import 'Models/cartItem.dart';
import 'Models/cart.dart';
import 'Models/user.dart';
import 'apiResponse.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'customWidgets/AlertDialog.dart';

class CheckOut extends StatefulWidget {
  List<Item> orderItems = [];

  CheckOut({@required this.orderItems});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  double totalPrice = 0;
  bool isSignIn = false;
  bool paymentStatus = false;
  String paymentErrorMsg = "";
  User user;
  List array = [];

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

  sendPayment() {
    int paymentMethod = 1;
    var request = new MFExecutePaymentRequest(paymentMethod, 5);
    request.customerName = "Hussain";
    request.customerEmail = "hello@gmail.com";
    request.customerMobile = "62228494";
    request.mobileCountryCode = "+965";
    MFSDK.executePayment(context, request, MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) {
      if (result.isSuccess()) {
        showDialog(
            context: context,
            builder: (_) => invoiceDialog(context, request, invoiceId));
      } else {
        showDialog(
            context: context,
            builder: (_) => messageDialog(context, result.error.message));
      }
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
    MFSDK.init('https://apitest.myfatoorah.com/',
        'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL');
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
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('images/delivery.jpg'),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAllAddress(
                                                    notifyCheckoutPage:
                                                    refresh,
                                                    user: user)));
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
        ],),
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
            onPressed: () async {
              if (user != null) {
                if (user.address == null) {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          messageDialog(context, "user address not found"));
                } else {
                  var getOrderId =
                      await placeOrder(user, cart.basketItems, context);
                  sendPayment();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             FollowOrder(orderId: getOrderId)));
                }
              } else {
                showDialog(
                    context: context,
                    builder: (_) => messageDialog(context, "user not found"));
              }
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
