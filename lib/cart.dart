import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appfixed/Models/cart.dart';
import 'package:flutter_appfixed/Models/cartItem.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart, child) {
      return Center(
          child: ListView.builder(
              itemCount: cart.basketItems.length,
              itemBuilder: (context, i) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.only(right: 20.0),
                        //height: 100,
                        color: Colors.grey[200],
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.lightGreen,
                              child: Image.network(
                                cart.basketItems[i].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 100,
                                width: 100,
                                //color: Colors.redAccent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      cart.basketItems[i].price.toString() + " KWD",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Droid',
                                          fontSize: 16,
                                          color: Colors.lightGreen),
                                    ),
                                    InkWell(
                                      child: Icon(Icons.delete_forever),
                                      onTap: (){
                                        cart.remove(cart.basketItems[i]);
                                      },
                                    )
                                  ],
                                )),
                            Column(
                              children: [
                                Text(
                                  cart.basketItems[i].name,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'Droid', fontSize: 16, color: Colors.grey[700]),
                                ),
                                Text(
                                  'الطلبات الجانبية',
                                  style: TextStyle(
                                      fontFamily: 'Droid', fontSize: 14, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }));
    });
  }
}
// Text(cart.basketItems.length > 0 ?  cart.basketItems[0].name : "No items")
