import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/cartItem.dart';


class CheckOut extends StatelessWidget {
  List<Item> orderItems = [];
  CheckOut({@required this.orderItems});
  double totalPrice = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Checkout'),),
      body:Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              CircleAvatar(child: Icon(Icons.ac_unit),),
              CircleAvatar(child: Icon(Icons.ac_unit),),
              CircleAvatar(child: Icon(Icons.ac_unit),),
            ],),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (BuildContext, i){
                  return ListTile(
                    title:Text(orderItems[i].productItem.name) ,
                    subtitle:Text(orderItems[i].getTotalItemPrice.toString()) ,
                  );
                }
            ),
          )
        ],
      ),

    );
  }
}
