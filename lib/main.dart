import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'package:flutter_appfixed/login/login.dart';
import 'homePage.dart';
import 'bestSales.dart';
import 'selectCategory.dart';
import 'cart.dart';
import 'package:flutter_appfixed/Models/cart.dart';
import 'package:provider/provider.dart';
import 'customWidgets/customDrawer.dart';



void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Carts(),
    child: MaterialApp(
      //home: LoginPage(),
      initialRoute: 'login',
      routes: {
        'MyApp': (context) => MyApp(),
        'home': (context) => HomePage(),
        'selectCategory': (context) => SelectCategoryItems(),
        'login': (context) => LoginPage(),
      },
      debugShowCheckedModeBanner: false,
    ),
  ));
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


    final User user = ModalRoute.of(context).settings.arguments;

    return Consumer<Carts>(builder: (context, cart, child) {
      return Scaffold(
        endDrawer: CustomDrawer(user: user),
        appBar: AppBar(
          title: Text(
            'زوارة',
            style: TextStyle(
                color: Colors.black45, fontFamily: 'Droid', fontSize: 20),
          ),
          leading: SizedBox(
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
                              Icons.shopping_basket,
                              color: Colors.black54,
                            ),
                            onPressed: (){
                              setState(() {
                                _selectedPage = 2;
                              });

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
          //iconTheme: IconThemeData(color: Colors.black45),
          actions: [
            Builder(
                builder: (BuildContext context) => IconButton(
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      icon: Icon(Icons.menu),
                      color: Colors.black45,
                    ))
          ],
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
        ),
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
              label: "الرئيسية",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "القائمة",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "المشتريات",
            ),
          ],
          selectedLabelStyle: TextStyle(fontSize: 16, fontFamily: 'Droid'),
          selectedItemColor: Colors.orangeAccent,
          unselectedLabelStyle: TextStyle(fontSize: 14, fontFamily: 'Droid'),
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
