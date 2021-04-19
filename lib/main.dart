import 'package:flutter/material.dart';
import 'homePage.dart';
import 'bestSales.dart';
import 'apiresponse.dart';
import 'selectCategory.dart';

void main() {

  runApp(
    MaterialApp(
      home: MyApp(),
      routes: {
        'categories' : (context){
          return SelectCategoryItems();
        }
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  Widget currentScreen;
  final _pageOptions = [
    HomePage(),
    BestSales(),
    BestSales(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FutureBuilder(
        future: getSettingsData(),
        builder: (context, snapshot){
          if (snapshot.hasData){
          return Text(snapshot.data[0]['appName'], style: TextStyle(
              fontFamily: 'Droid',
              fontSize: 22,
              color: Colors.black54
          ),); }else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
      elevation: 0.0,
      leading: Icon(Icons.shopping_cart, color: Colors.black54,size: 22,),
      backgroundColor: Colors.white,),
      body: IndexedStack(
        index: _selectedPage,
        children: _pageOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('الصفحة الرئيسية',style: TextStyle(fontFamily: 'Droid', fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            title: Text('قائمة المأكولات',style: TextStyle(fontFamily: 'Droid', fontSize: 12),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('مشترياتي',style: TextStyle(fontFamily: 'Droid', fontSize: 12),),
          ),



        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
