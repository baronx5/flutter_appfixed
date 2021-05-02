import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  User user;

  CustomDrawer({this.user});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String name;
  String email;
  bool isSignIn = false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name = preferences.getString('name');
    email = preferences.getString('email');

    if (name != null) {
      setState(() {
        name = preferences.getString('name');
        email = preferences.getString('email');
        isSignIn = true;
      });
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: isSignIn ? Text(name, style: TextStyle(color: Colors.orange),) : Text(''),
                accountEmail: isSignIn ? Text(email, style: TextStyle(color: Colors.orange)) : Text('مستخدم افتراضي', style: TextStyle(fontFamily: 'Droid',color: Colors.grey)),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "A",
                    style:
                        TextStyle(fontSize: 40.0, color: Colors.orangeAccent),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'متابعة الطلبات',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Droid',
                  ),
                ),
                leading: Icon(Icons.follow_the_signs),
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'الدعم الفني',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Droid',
                  ),
                ),
                leading: Icon(Icons.support),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text(
                  'الملاحظات والشكاوي',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Droid',
                  ),
                ),
                leading: Icon(Icons.fastfood),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text(
                  'الاعدادات',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Droid',
                  ),
                ),
                leading: Icon(Icons.settings),
                onTap: () {},
              ),
              Divider(),
            ],
          )),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: isSignIn ? ListTile(
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Droid',
                ),
              ),
              leading: Icon(Icons.logout),
              onTap: () async{
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.remove('name');
                preferences.remove('email');
                Navigator.of(context).pushNamed('login');

              },
            ) : ListTile(
              title: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Droid',
                ),
              ),
              leading: Icon(Icons.logout),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
