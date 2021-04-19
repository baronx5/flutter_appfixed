import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'bestSales.dart';
import 'categories.dart';
import 'sliders.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 80,
          margin: EdgeInsets.all(10.0),
          child: SearchBar(),
        ), // Search bar
        Container(
          height: 350,
          child: HomeSlider(),
        ), // Slider
        Container(
          margin: EdgeInsets.all(10.0),
          height: 35,
          alignment: Alignment.topRight,
          child: Text(
            'شنو تبي تاكل ؟',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Droid',
            ),
          ),
        ), // Text
        Container(
          height: 180,
          child: HomeCategories(),
        ), // Menu Categories
        Container(
          margin: EdgeInsets.all(10.0),
          height: 35,
          alignment: Alignment.topRight,
          child: Text(
            'الاكثر طلبا هذا الشهر',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Droid',
            ),
          ),
        ), // Text (best Sales)
        BestSales(),
      ],
    );
  }
}
