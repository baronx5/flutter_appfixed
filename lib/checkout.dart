import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/cartItem.dart';
import 'package:flutter_appfixed/Models/cart.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  List<Item> orderItems = [];

  CheckOut({@required this.orderItems});

  double totalPrice = 0;

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
                    Padding(
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
                                'صباح الاحمد',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Droid'),
                              ),
                              Text(
                                'قطعه ٦ شارع ٩ منزل ٥',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Droid',
                                    color: Colors.grey),
                              ),
                              Text(
                                'تغيير',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Droid',
                                    color: Colors.orange),
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
                  Text('ملخص الدفع', style: TextStyle(fontSize: 18,fontFamily: 'Droid')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(' طلب  ', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                          Text( orderItems.length.toString(), style: TextStyle(fontSize: 14,fontFamily: 'Droid')),

                        ],
                      ),
                      Text('مجموع الطلبات', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('0.5', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                          Text('KWD ', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                        ],
                      ),
                      Text('رسوم التوصيل', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text( cart.totalPrice.toString(), style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                          Text('KWD', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                        ],
                      ),
                      Text('المبلغ الاجمالي', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),

                    ],
                  ),

                ],
              ),
              Text('payment Details'),
              Text(orderItems.length.toString()),
              Text(cart.totalPrice.toString()),

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

            onPressed: () { },
            child: Text('تنفيذ الطلب', style: TextStyle(fontFamily: 'Droid', fontSize: 18),),
          ),
        ),
      );
    });
  }
}
