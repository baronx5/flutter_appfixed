import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appfixed/followUpOrder/followOrder.dart';
import 'package:flutter_appfixed/followUpOrder/orderView.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'address/ViewAllAddress.dart';
import 'address/address.dart';
import 'Models/cartItem.dart';
import 'Models/cart.dart';
import 'Models/user.dart';
import 'apiResponse.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  void initState() {
    getPref();
    super.initState();
    MFSDK.init('https://apitest.myfatoorah.com/',
        'j4lc68ycMg3Vk30apbsbLnGWMtWbLXzRGilTN4l8ZTz6qlZ5SI7SYZbrRdjtI5FuRWz3lg6jnCV15VBU9cFhA_pRo4qiQCyZtTdjaAkN2QOq-TOWRuj81B6dVbP4DR-nhs4c_KVsYqfHmHcqb3hVS9Aymc771P_e13LU4X_Zd3bKyVY_L9WWBQ3bQtK-gAHpn9RVoVioQo1g_ZaaAiV4GP8scxfEMy02uN-OvcRGXExThTanoqwKwXgzU9dxJQteD0vbgVfeVbtzoWIjnroB2oPQuE_PZtG1ljdq0r5jFJp3fREVJEa2K8DjkMIo0KHavlPBClW11HyBYsnmGxVjXGFMeXVFRrXosl9KudRR8s98QusPDcbP1e4oDv3iJo8bYMDAT8F327FGBjGdonzNsaOIvfzCMdI-jpxaZ7wh5eO-KTTNX4N5xP6Vp0CShkhPTT16z84JFQvnzaJ6nRtYJ6w9AJbi3WghON9x350OIaR0ffThTrincoBGo_0szIj-TcyZhNAT4RRRd01gEm3O6d-qeDVL6xhVKYh9g8Op1AWBB5q5oWlPD8VSRHsWzR7Z05RdPK8qKOXaoA9iQBpo9HS_qddqF9KCyOvy9fhOtYOxdLYv5NpbefMAGfLl87NzjBxCUfKR5KPnGg3Jibv6xSk500KIo_xoKQvcsAo5PvEGvUcQ');
  }

  pay(Carts cart) {
    // The value 1 is the paymentMethodId of KNET payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 1;
    var request = new MFExecutePaymentRequest(paymentMethod, cart.totalPrice);
    MFSDK.setUpAppBar(isShowAppBar: false);
    MFSDK.executePayment(
        context,
        request,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  print(result.response.toJson().toString()),
                  placeOrder(user, cart.basketItems, context).then((value) {
                    if (value != null) {
                      cart.clearBasket();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderView(
                                    orderId: value.id,
                                    orderDetails: value,
                                  )));
                    }
                  })
                }
              else
                {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          messageDialog(context, result.error.message))
                }
            });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
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
        body: ListView(
          children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.orangeAccent,
                                      size: 33,
                                    ),
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.orangeAccent,
                                      size: 33,
                                    ),
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "لايوجد عنوان مسجل مسبقاً",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Droid'),
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
                                                  builder: (context) =>
                                                      AddAddress(
                                                          notifyCheckoutPage:
                                                              refresh)),
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
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                              Text(widget.orderItems.length.toString(),
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                            ],
                          ),
                          Text('مجموع الطلبات',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(' دك  ',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                              Text('0.5',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                            ],
                          ),
                          Text('رسوم التوصيل',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(' دك  ',
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                              Text(cart.totalPrice.toString(),
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Droid')),
                            ],
                          ),
                          Text('المبلغ الاجمالي',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Droid')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
            onPressed: () async {
              if (user != null) {
                if (user.address == null) {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          messageDialog(context, "user address not found"));
                } else {
                  pay(cart);
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
