import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/order.dart';
import 'package:flutter_appfixed/followUpOrder/orderView.dart';
import '../Models/user.dart';
import 'dart:convert';
import '../apiResponse.dart';

class FollowOrder extends StatefulWidget {
  final User user;

  FollowOrder({@required this.user});

  @override
  _FollowOrderState createState() => _FollowOrderState(this.user);
}

class _FollowOrderState extends State<FollowOrder> {
  User user;

  _FollowOrderState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'قائمة الطلبيات',
            style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black54),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            SizedBox(
              child: Image(
                image: AssetImage('images/delivery.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                'قائمة الطلبيات (قيد الانتظار) الخاصة بك',
                style: TextStyle(fontSize: 18, fontFamily: 'Droid'),
              ),
            ),
            Container(
              color: Colors.white,
              child: FutureBuilder<List<Order>>(
                  future: getUserPendingOrders(user.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              background: Container(
                                color: Colors.red,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'الغاء الطلب',
                                    style: TextStyle(
                                        fontFamily: 'Droid',
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              onDismissed: (direction) {},
                              key: ValueKey<int>(snapshot.data[index].id),
                              child: new Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          snapshot.data[index].id.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        leading: Icon(
                                            Icons.location_history_outlined),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderView()),
                                          );
                                        },
                                      ),
                                      Divider()
                                    ],
                                  )),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                        child: Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.orange,
                            )));
                  }),
            ),
          ],
        ));
  }
}
