import 'package:flutter/material.dart';
import 'Models/product.dart';
import 'apiResponse.dart';
import 'productView.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBestSalesData(),
      builder: (context, products) {
        if (products.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1
            ),
            itemCount: products.data.length,
            itemBuilder: (context, i) {
              return Image(
                image: NetworkImage(products.data[i].image),
              );
            },

          );
        } else if (products.hasError) {
          return Text("${products.error}");
        }
        return new Container(
          height: 60.0,
          child: new Center(
              child: new CircularProgressIndicator(
                backgroundColor: Colors.grey,
              )),
        );
      },
    );
  }
}

