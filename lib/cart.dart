import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appfixed/Models/cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart, child) {
      return Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cart.basketItems.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.all(10.0),
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
                                cart.basketItems[i].productItem.image,
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
                                      cart.basketItems[i].getTotalItemPrice.toString() +
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      cart.basketItems[i].productItem.name,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: 'Droid',
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                    Container(
                                      height: 50,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: cart.basketItems[i].productItem.addons.length,
                                          itemBuilder: (context, index){

                                            return Text(
                                              " : " + cart.basketItems[i].productItem.addons[index].name ,textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontFamily: 'Droid',
                                                  fontSize: 12,
                                                  color: Colors.grey[500]),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                      );
                    }),
              ),
              Divider(),
              Container(
                height: 100,
                color: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextButton(onPressed: (){}, child: Text('اكمل الطلب', style: TextStyle(fontFamily: 'Droid', fontSize: 16),), style: ButtonStyle(
                          padding:
                          MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(5.0)),
                          foregroundColor:
                          MaterialStateProperty.all<
                              Color>(Colors.green),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green)))),),
                    ),
                    Text( "KWD "+' المجموع'+" "+ cart.totalPrice.toString(), style: TextStyle(fontSize: 16, fontFamily: 'Droid', color: Colors.black54),),
                  ],
                ),
              )

            ],
          ));
    });
  }
}
// Text(cart.basketItems.length > 0 ?  cart.basketItems[0].name : "No items")
