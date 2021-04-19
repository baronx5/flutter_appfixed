import 'package:flutter/material.dart';
import 'apiresponse.dart';


class HomeCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoriesData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length, // نحدد العدد للايتم بلدر
                itemBuilder: (context, i){   // ندخلها بالبلدر علشان اللوب
                  return InkWell(
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
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                          image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
                              image: NetworkImage(snapshot.data[i]['image']),
                              fit: BoxFit.cover)),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(snapshot.data[i]['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Droid',
                              fontSize: 18,
                            )),
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pushNamed('categories');
                    },
                  );
                },
              )
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

