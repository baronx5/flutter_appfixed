import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تحضير طلبك',
          style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text('طلب رقم : ٢١٢', style: TextStyle(fontFamily: 'Droid', fontSize: 22),)),
          Center(child: Text('توقيت الطلب : ١٠.١٥', style: TextStyle(fontFamily: 'Droid', fontSize: 22),)),

          Center(child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(30.0),
                margin: EdgeInsets.all(10),
                child: Icon(Icons.done),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle
                ),),
              Text('تم استلام طلبك', style: TextStyle(fontFamily: 'Droid')),
            ],
          ),),
          Center(
            child: Container(
              color: Colors.grey,
              child: Container(
                width: 2,
                height: 100,
                padding: EdgeInsets.all(10),
              ),
            ),
          ),
          Center(child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(30.0),
                margin: EdgeInsets.all(10),
                child: Icon(Icons.fastfood_outlined),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle
                ),),
              Text('جاري تحضير الطلب', style: TextStyle(fontFamily: 'Droid')),
            ],
          ),),
          Center(
            child: Container(
              color: Colors.grey,
              child: Container(
                width: 2,
                height: 100,
                padding: EdgeInsets.all(10),
              ),
            ),
          ),
          Center(child: Column(
    children: [
    Container(
    padding: EdgeInsets.all(30.0),
    margin: EdgeInsets.all(10),
    child: Icon(Icons.delivery_dining),
    decoration: BoxDecoration(
    color: Colors.orange,
    shape: BoxShape.circle
    ),),
              Text('جاري توصيل الطلب', style: TextStyle(fontFamily: 'Droid')),
    ],
    ),)


        ],
      ),
    );
  }
}
