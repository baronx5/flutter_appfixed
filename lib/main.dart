import 'package:flutter/material.dart';
import 'homePage.dart';
import 'bestSales.dart';
import 'apiresponse.dart';
import 'selectCategory.dart';
import 'cart.dart';
import 'package:flutter_appfixed/Models/cart.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appfixed/Models/cartItem.dart';

void main() {

  runApp(
    ChangeNotifierProvider(
        create: (context) => Carts(),
      child: MaterialApp(
        //home: LoginPage(),
        initialRoute: 'MyApp',
        routes: {
          'MyApp' : (context) => MyApp(),
          'home' : (context) => HomePage(),
          'selectCategory' : (context) => SelectCategoryItems(),
        },
        debugShowCheckedModeBanner: false,
      ),
    )
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
    CartPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Consumer<Carts>(
        builder: (context, cart, child){
      return Scaffold(
        appBar: AppBar(title: FutureBuilder(
          future: getSettingsData(),
          builder: (context, settings){
            if (settings.hasData){
              return Text(settings.data[0].appName, style: TextStyle(
                  fontFamily: 'Droid',
                  fontSize: 22,
                  color: Colors.black54
              ),); }else if (settings.hasError) {
              return Text("${settings.error}");
            } else if (settings.hasError) {
              return Text("${settings.error}");
            }

            // By default, show a loading spinner.
            return new Container(
              height: 60.0,
              child: new Center(child: new CircularProgressIndicator(
                backgroundColor: Colors.grey,
              )),
            );
          },
        ),
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Row(
                children: [
                  Icon(Icons.shopping_cart, color: Colors.black54,size: 22,),
                  Text(cart.basketItems.length.toString(), style: TextStyle(color: Colors.black54),)
                ],
              ),
              onTap: (){
                setState(() {
                  _selectedPage = 2;
                });
              },
            ),
          ),
          backgroundColor: Colors.white,),
        body: IndexedStack(
          index: _selectedPage,
          children: _pageOptions,
        )
        ,
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
              icon: Icon(Icons.menu),
              title: Text('قائمة المأكولات',style: TextStyle(fontFamily: 'Droid', fontSize: 12),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('مشترياتي',style: TextStyle(fontFamily: 'Droid', fontSize: 12),),
            ),



          ],
        ),
      );
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}

