import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'apiresponse.dart';
import 'productView.dart';
import 'package:flutter_appfixed/Models/product.dart';
import 'package:flutter_appfixed/Models/categories.dart';
import 'package:flutter_appfixed/Models/cart.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class SelectCategoryItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Categories category = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: CustomAppBar(),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
                height: 300,
                child: Container(
                  margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                      ),
                      image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.7), BlendMode.dstATop),
                          image: NetworkImage(category.image),
                          fit: BoxFit.cover)),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(category.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Droid',
                          fontSize: 18,
                        )),
                  ),
                )),
            Divider(),
            Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.all(10.0),
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xffe9ecef),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                'اختر مايناسبك ..',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Droid',
                  fontSize: 16,
                ),
              ),
            ),
            FutureBuilder(
              future: getProductsData(category.id),
              builder: (context, products) {
                if (products.hasData) {
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    //physics: const ClampingScrollPhysics(),
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
                                    style: TextStyle(
                                        fontSize: 14, fontFamily: "Droid")),
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(5.0)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side:
                                                BorderSide(color: Colors.red)))),
                                onPressed: () {
                                  Product product = Product(
                                      id: products.data[i].id,
                                      name: products.data[i].name,
                                      description: products.data[i].description,
                                      image: products.data[i].image,
                                      price: products.data[i].price);
                                  Navigator.of(context).push(MaterialPageRoute(
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
            )
          ],
        ));
  }
}

class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(builder: (context, cart, child) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    splashColor: Colors.red, // inkwell color
                    child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Container(
                              height: 150.0,
                              width: 30.0,
                              child: new GestureDetector(
                                onTap: () {
                                  cart.basketItems.length.toString();
                                },
                                child: new Stack(
                                  children: <Widget>[
                                    new IconButton(
                                      icon: new Icon(
                                        FontAwesomeIcons.shoppingBag,
                                        color: Colors.black45,
                                      ),
                                      onPressed: (){
                                        //_selectedPage = 2;
                                      },
                                    ),
                                    cart.basketItems.length == 0
                                        ? new Container()
                                        : new Positioned(
                                        child: new Stack(
                                          children: <Widget>[
                                            new Icon(Icons.brightness_1,
                                                size: 20.0,
                                                color: Colors.orange[800]),
                                            new Positioned(
                                                top: 3.0,
                                                right: 6.0,
                                                child: new Center(
                                                  child: new Text(
                                                    cart.basketItems.length
                                                        .toString(),
                                                    style: new TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11.0,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                )),
                                          ],
                                        )),
                                  ],
                                ),
                              )),
                        )),
                    onTap: () {
                      //Navigator.pop(context);
                    },
                  ),
                ),
              ),
              FutureBuilder(
                future: getSettingsData(),
                builder: (context, settings) {
                  if (settings.hasData) {
                    return Text(
                      settings.data[0].appName,
                      style: TextStyle(
                          fontFamily: 'Droid',
                          fontSize: 22,
                          color: Colors.black54),
                    );
                  } else if (settings.hasError) {
                    return Text("${settings.error}");
                  } else if (settings.hasError) {
                    return Text("${settings.error}");
                  }

                  // By default, show a loading spinner.
                  return new Container(
                    height: 60.0,
                    child: new Center(
                        child: new CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                        )),
                  );
                },
              ),
              ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    splashColor: Colors.red, // inkwell color
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(FontAwesomeIcons.ellipsisV,
                          color: Colors.black54),
                    ),
                    onTap: () {
                      //Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
