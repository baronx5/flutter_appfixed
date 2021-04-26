import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/product.dart';
import 'apiresponse.dart';
import 'productView.dart';

class BestSales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductsData(),
      builder: (context, products) {
        if (products.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: products.data.length,
            itemBuilder: (context, i) {
              return new Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    leading: Image.network(products.data[i].image),
                    title: Text(
                      products.data[i].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Droid',
                      ),
                    ),
                    subtitle: Text(products.data[i].description,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Droid',
                        )),
                    trailing: TextButton(
                        child: Text("طلب".toUpperCase(),
                            style:
                                TextStyle(fontSize: 14, fontFamily: "Droid")),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(5.0)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)))),
                        onPressed: () {
                          Product product = Product(
                              id: products.data[i].id,
                              name: products.data[i].name,
                              description: products.data[i].description,
                              image: products.data[i].image,
                              price: products.data[i].price);
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                            builder: (context) => ProductSelect(
                              passedProduct: product,
                            ),
                          ));
                        }),
                  ));
            },
            separatorBuilder: (context, index) {
              return Divider();
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
