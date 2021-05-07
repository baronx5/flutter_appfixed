import 'package:flutter/material.dart';
import 'Models/cartItem.dart';
import 'Models/cart.dart';
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
  int uid;
  String email;
  bool isSignIn = false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    uid = preferences.getInt('id');
    email = preferences.getString('email');
    if (uid != null) {
      setState(() {
        uid = preferences.getInt('id');
        email = preferences.getString('email');
        isSignIn = true;
      });
    }
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
                    isSignIn == true ? FutureBuilder(
                        future: getAdr(uid),
                        builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: Text('Loading...'));
                      }
                      else{
                        if(snapshot.hasError){
                          return Center(child: Text('Error : ${snapshot.error}'),);
                        }else {
                          return Padding(
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
                                      snapshot.data != 0 ? snapshot.data[0].area : " Something wrong",
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'Droid'),
                                    ),
                                    Row(
                                      children: [
                                        Text(snapshot.data[0].housenumber,style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),
                                        Text('شقة',style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),

                                        Text(snapshot.data[0].floor,style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),
                                        Text('دور',style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),

                                        Text(snapshot.data[0].housenumber,style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),
                                        Text('منزل',style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),

                                        Text(snapshot.data[0].jada,style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),
                                        Text('جادة',style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),

                                        Text(snapshot.data[0].street,style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),
                                        Text('شارع',style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),

                                        Text(snapshot.data[0].block,style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),
                                        Text('ق',style: TextStyle( fontSize: 14, fontFamily: 'Droid', color: Colors.grey),),
                                      ],
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
                          );
                        }
                      }
                    }
                    ): Padding(
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
                              Text("لايوجد عنوان اضف عنوان",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Droid'),
                              ),
                              Text(
                                'اضافة عنوان',
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
                          Text( widget.orderItems.length.toString(), style: TextStyle(fontSize: 14,fontFamily: 'Droid')),

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
                          Text(' دك  ', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                          Text('0.5', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),

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
                          Text(' دك  ', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                          Text(cart.totalPrice.toString(), style: TextStyle(fontSize: 14,fontFamily: 'Droid')),
                        ],
                      ),
                      Text('المبلغ الاجمالي', style: TextStyle(fontSize: 14,fontFamily: 'Droid')),

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

            onPressed: () { },
            child: Text('تنفيذ الطلب', style: TextStyle(fontFamily: 'Droid', fontSize: 18),),
          ),
        ),
      );
    });
  }
}
