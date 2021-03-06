import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/order.dart';

class OrderView extends StatelessWidget {
  final Order orderDetails;

  OrderView({this.orderDetails});

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
      body: ListView(children: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${orderDetails.id}',
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
                            color: orderDetails.level == 'delivery'
                                ? Colors.orange[400]
                                : Colors.grey[200],
                            shape: BoxShape.circle),
                      ),
                      Text('جاري توصيل الطلب',
                          style: TextStyle(fontFamily: 'Droid')),
                    ],
                  ),
                  Container(
                    color: Colors.grey,
                    child: Container(
                      width: 35,
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
                            color: orderDetails.level == 'cooking' ||
                                    orderDetails.level == 'delivery'
                                ? Colors.orange[400]
                                : Colors.grey[200],
                            shape: BoxShape.circle),
                      ),
                      Text('جاري تحضير الطلب',
                          style: TextStyle(fontFamily: 'Droid')),
                    ],
                  ),
                  Container(
                    color: Colors.grey,
                    child: Container(
                      width: 35,
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
                            color: orderDetails.level == 'new' ||
                                    orderDetails.level == 'cooking' ||
                                    orderDetails.level == 'delivery'
                                ? Colors.orange[400]
                                : Colors.grey[200],
                            shape: BoxShape.circle),
                      ),
                      Text('تم استلام طلبك',
                          style: TextStyle(fontFamily: 'Droid')),
                    ],
                  ),
                ],
              ),
              Divider(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'تفاصيل الطلب',
                    style: TextStyle(fontFamily: 'Droid', fontSize: 22),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderDetails.orderItems.length,
                      itemBuilder: (context, index) {
                        print(orderDetails.orderItems.length);
                        return Container(
                          color: Colors.grey[100],
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                color: Colors.red,
                                child: Image.network(orderDetails
                                    .orderItems[index].productItem.image),
                              ),
                              orderDetails.orderItems[index].productItem.addons
                                          .length >
                                      0
                                  ? Container(
                                      width: 50,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: orderDetails
                                              .orderItems[index]
                                              .productItem
                                              .addons
                                              .length,
                                          itemBuilder: (context, i) {
                                            return Text(
                                              orderDetails.orderItems[index]
                                                  .productItem.addons[i].name,
                                              style: TextStyle(
                                                  fontFamily: 'Droid'),
                                            );
                                          }),
                                    )
                                  : Text(
                                      'لاتوجد اضافات',
                                      style: TextStyle(fontFamily: 'Droid'),
                                    ),
                              Text(
                                orderDetails
                                        .orderItems[index].productItem.name +
                                    'x ${orderDetails.orderItems[index].quantity}',
                                style: TextStyle(fontFamily: 'Droid'),
                              ),
                            ],
                          ),
                        );
                      })),
            ],
          ),
        ),
      ]),
    );
  }
}
