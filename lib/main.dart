import 'package:flutter/material.dart';
import 'homePage.dart';
import 'bestSales.dart';
import 'selectCategory.dart';
import 'cart.dart';
import 'package:flutter_appfixed/Models/cart.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'apiresponse.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Carts(),
    child: MaterialApp(
      //home: LoginPage(),
      initialRoute: 'MyApp',
      routes: {
        'MyApp': (context) => MyApp(),
        'home': (context) => HomePage(),
        'selectCategory': (context) => SelectCategoryItems(),
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
    return Consumer<Carts>(builder: (context, cart, child) {
      return Scaffold(
        appBar: CustomAppBar(),
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
              label: "الرئيسية" ,
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
          selectedLabelStyle:  TextStyle(fontSize: 16, fontFamily: 'Droid'),
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

// Calling Custom Class
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
                                        color: Colors.black54,
                                      ),
                                      onPressed: null,
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
