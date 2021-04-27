import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'apiresponse.dart';
import 'productView.dart';
import 'package:flutter_appfixed/Models/product.dart';

class SelectCategoryItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int catId =
    ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
        appBar: CustomAppBar(),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
                height: 200,
                child: Container(
                  margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                      ),
                      image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.7), BlendMode.dstATop),
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1428660386617-8d277e7deaf2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1567&q=80'),
                          fit: BoxFit.cover)),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text('ألذ و اشهى البرجر ',
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
              future: getProductsData(catId),
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Material(
                //color: Colors.white, // button color
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
