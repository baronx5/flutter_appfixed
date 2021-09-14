import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  final int orderId;

  OrderView({this.orderId});

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
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'طلب رقم : ${orderId.toString()}',
              style: TextStyle(fontFamily: 'Droid', fontSize: 22),
            ),
            Text(
              'توقيت الطلب : ١٠.١٥',
              style: TextStyle(fontFamily: 'Droid', fontSize: 22),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.all(10),
                      child: Icon(Icons.delivery_dining),
                      decoration: BoxDecoration(
                          color: Colors.grey[200], shape: BoxShape.circle),
                    ),
                    Text('جاري توصيل الطلب',
                        style: TextStyle(fontFamily: 'Droid')),
                  ],
                ),
                Container(
                  color: Colors.grey,
                  child: Container(
                    width: 40,
                    height: 1,
                    padding: EdgeInsets.all(10),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.all(10),
                      child: Icon(Icons.fastfood_outlined),
                      decoration: BoxDecoration(
                          color: Colors.grey[200], shape: BoxShape.circle),
                    ),
                    Text('جاري تحضير الطلب',
                        style: TextStyle(fontFamily: 'Droid')),
                  ],
                ),
                Container(
                  color: Colors.grey,
                  child: Container(
                    width: 40,
                    height: 1,
                    padding: EdgeInsets.all(10),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.all(10),
                      child: Icon(Icons.done),
                      decoration: BoxDecoration(
                          color: Colors.orange[400], shape: BoxShape.circle),
                    ),
                    Text('تم استلام طلبك', style: TextStyle(fontFamily: 'Droid')),
                  ],
                ),
              ],
            ),
            Divider(),
            Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('تفاصيل الطلب', style: TextStyle(fontFamily: 'Droid', fontSize: 22),),
            ),),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Text('image'),
                  ),
                  Text('AddOns'),
                  Text('name')
                ],),
            )


          ],
        ),
      ),
    );
  }
}
