import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appfixed/Models/cart.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart,child) {
      return Center(

          child: ListView.builder(
              itemCount: cart.basketItems.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(cart.basketItems[i].name.toString()),
                  subtitle: Text(cart.basketItems[i].price.toString()),

                );
              }
            // Text(cart.basketItems.length > 0 ?  cart.basketItems[0].name : "No items")
          )

      );
    }
    );
  }

}
