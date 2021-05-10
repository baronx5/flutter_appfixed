import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/addOns.dart';
import 'apiResponse.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appfixed/Models/cart.dart';
import 'package:flutter_appfixed/Models/cartItem.dart';
import 'package:flutter_appfixed/Models/product.dart';

class ProductSelect extends StatefulWidget {
  final Product passedProduct;

  ProductSelect({this.passedProduct});

  @override
  _ProductSelectState createState() => _ProductSelectState(passedProduct);
}

class _ProductSelectState extends State<ProductSelect> {
  List checkBoxesHandle = []; // to add boxes .
  List<ProductAddons> checkBoxes = [];
  double addonsPrice = 0.0;
  int counter = 1; // number of orders = 1
  double totalPrice = 0.0;

  // Passing Details from main class
  Product passedProduct;

  _ProductSelectState(this.passedProduct);

  @override
  Widget build(BuildContext context) {
    double totalpricefinal = (addonsPrice + passedProduct.price) * counter;

    return Consumer<Carts>(// List of Carts from Consumer.
        builder: (context, cart, child) {
      return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: CustomAppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(passedProduct.image,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      //height: 300,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: new Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                  title: Text(
                                    passedProduct.name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Droid'),
                                  ),
                                  subtitle: Text(passedProduct.description,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Droid",
                                          color: Colors.grey)),
                                  trailing: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        "KWD ${passedProduct.price}"
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 14, fontFamily: "Droid")),
                                    style: ButtonStyle(
                                        padding:
                                            MaterialStateProperty.all<EdgeInsets>(
                                                EdgeInsets.all(5.0)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.lightGreen),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.lightGreen)))),
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: 104,
                              decoration: BoxDecoration(
                                  color: Color(0xffffE6E6),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )),
                              child: Row(
                                children: [
                                  Text('60 Min'),
                                  Icon(Icons.delivery_dining),
                                ],
                              ),
                            ),
                          ),
                          Text('اضافات اختيارية',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Droid",
                                  color: Colors.grey)),
                          FutureBuilder(
                            future: getAddonsData(passedProduct.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, i) {
                                    ProductAddons product = snapshot.data[i];
                                    if (checkBoxesHandle.length <
                                        snapshot.data.length) {
                                      checkBoxesHandle.add(false);
                                    }
                                    return new Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: CheckboxListTile(
                                        title: Text(product.name,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Droid")),
                                        subtitle: product.price != 0
                                            ? Text(
                                                product.price.toString() +
                                                    " دك ",
                                                style: TextStyle(
                                                    fontFamily: 'Droid'),
                                              )
                                            : Text('free'),
                                        value: checkBoxesHandle[i],
                                        onChanged: (bool value) {
                                          setState(() {
                                            checkBoxesHandle[i] =
                                                checkBoxesHandle[i]
                                                    ? false
                                                    : true;
                                            if (checkBoxesHandle[i]) {
                                              checkBoxes.add(product);
                                              passedProduct.addons = checkBoxes;
                                              addonsPrice += product.price;
                                            } else {
                                              checkBoxes.remove(product);
                                              passedProduct.addons = checkBoxes;
                                              if (addonsPrice > 0) {
                                                addonsPrice -= product.price;
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                                maxLines: 1,
                                maxLength: 60,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration.collapsed(
                                    hintText: "اضف ملاحطاتك ..",
                                    hintStyle: TextStyle(fontFamily: 'Droid')),
                                onChanged: (value) {
                                  if (value != null) {
                                    passedProduct.notes = value;
                                  } else {
                                    passedProduct.notes = " ";
                                  }
                                }),
                          ),
                          Divider(),
                          Container(
                            height: 100,
                            width: 300,
                            //color: Colors.lightGreen,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.all(5),
                                  child: OutlinedButton(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black54,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: CircleBorder(),
                                      side: BorderSide(
                                          width: 1, color: Colors.black54),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (counter < 20) {
                                          counter++;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  '$counter',
                                  style: TextStyle(fontSize: 22),
                                ),
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.all(5),
                                  child: OutlinedButton(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black54,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: CircleBorder(),
                                      side: BorderSide(
                                          width: 1, color: Colors.black54),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (counter > 1) {
                                          counter--;
                                        } else {
                                          counter = 1;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  ': العدد ',
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: 'Droid'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
            SizedBox(
              //height: 140,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                width: double.infinity,
                height: 100,
                child: FlatButton(
                  child: Text(
                    " " + " ${totalpricefinal.toString()} " 'آكمل الطلب',
                    style: TextStyle(fontSize: 20, fontFamily: "Droid"),
                  ),
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  onPressed: () {
                    Item item =
                        Item(productItem: passedProduct, quantity: counter);
                    cart.add(item);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// Calling Custom Class
class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
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
                      child: Icon(Icons.arrow_back_outlined)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((14)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Text(
                    "4.5",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
