import 'package:flutter/material.dart';
import 'apiResponse.dart';
import 'package:flutter_appfixed/Models/categories.dart';

class HomeCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoriesData(),
      builder: (context, categories) {
        if (categories.hasData) {
          return Container(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.data.length, // نحدد العدد للايتم بلدر
                itemBuilder: (context, i) {
                  // ندخلها بالبلدر علشان اللوب
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
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                              image: NetworkImage(categories.data[i].image),
                              fit: BoxFit.cover)),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(categories.data[i].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Droid',
                              fontSize: 18,
                            )),
                      ),
                    ),
                    onTap: () {
                      Categories category = categories.data[i];
                      Navigator.of(context)
                          .pushNamed('selectCategory', arguments: category);
                    },
                  );
                },
              ));
        } else if (categories.hasError) {
          return Text("${categories.error}");
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
    );
  }
}
