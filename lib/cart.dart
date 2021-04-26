import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appfixed/Models/cart.dart';

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
                                      cart.basketItems[i].price.toString() +
                                          " KWD",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Droid',
                                          fontSize: 14,
                                          color: Colors.lightGreen),
                                    ),
                                    InkWell(
                                      child: TextButton(
                                          child: Text('حذف', style: TextStyle(fontFamily: 'Droid', fontSize: 12),),
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all<EdgeInsets>(
                                                      EdgeInsets.all(5.0)),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.red),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(18.0),
                                                      side: BorderSide(color: Colors.red))))),
                                      onTap: () {
                                        cart.remove(cart.basketItems[i]);
                                      },
                                    )
                                  ],
                                )),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    cart.basketItems[i].name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'Droid',
                                        fontSize: 14,
                                        color: Colors.grey[700]),
                                  ),
                                  Text(
                                    cart.basketItems[i].description,textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: 'Droid',
                                        fontSize: 12,
                                        color: Colors.grey[500]),
                                  ),
                                ],
                              ),
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
