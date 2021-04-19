import 'package:flutter/material.dart';
import 'apiresponse.dart';
import 'productView.dart';

class BestSales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductsData(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return new Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    leading: Image.network(snapshot.data[i]['image']),
                    title: Text(
                      snapshot.data[i]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Droid',
                      ),
                    ),
                    subtitle: Text(snapshot.data[i]['description'],style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Droid',
                    )),
                    trailing: TextButton(
                        child: Text(
                            "طلب".toUpperCase(),
                            style: TextStyle(fontSize: 14, fontFamily: "Droid")
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5.0)),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)
                                )
                            )
                        ),
                        onPressed: () {
                          var getId = snapshot.data[i]['id'];
                          var getName = snapshot.data[i]['name'];
                          var getDescription = snapshot.data[i]['description'];
                          var getImage = snapshot.data[i]['image'];
                          var getPrice = snapshot.data[i]['price'];
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductSelect(
                              getId: getId,
                              getName: getName,
                              getDescription: getDescription,
                              getImage: getImage,
                              getPrice: getPrice,
                            ),
                          ));
                        }
                    ),
                  ));
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );

        }else if (snapshot.hasError){
          return Text("${snapshot.error}");
        } return new Container(
          height: 60.0,
          child: new Center(child: new CircularProgressIndicator(
            backgroundColor: Colors.grey,
          )),
        );
      },
    );
  }
}

