import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'package:flutter_appfixed/followUpOrder/followOrder.dart';
import 'package:flutter_appfixed/support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile.dart';
import '../settings.dart';

class CustomDrawer extends StatefulWidget {
  User user;

  CustomDrawer({this.user});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isSignIn = false;
  User user;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user') != null) {
      setState(() {
        user = User.fromJson(jsonDecode(preferences.getString('user')));
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
                accountName: isSignIn
                    ? Text(
                        user.phone.toString(),
                        style: TextStyle(color: Colors.orange),
                      )
                    : Text(''),
                accountEmail: isSignIn
                    ? Text(user.email, style: TextStyle(color: Colors.orange))
                    : Text('مستخدم افتراضي',
                        style:
                            TextStyle(fontFamily: 'Droid', color: Colors.grey)),
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
                  'ملفي الشخصي',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Droid',
                  ),
                ),
                leading: Icon(Icons.supervised_user_circle_outlined),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              Divider(),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FollowOrder(
                                user: user,
                              )));
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Support()));
                },
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
              Divider(),
            ],
          )),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: isSignIn
                ? ListTile(
                    title: Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Droid',
                      ),
                    ),
                    leading: Icon(Icons.logout),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.remove('user');
                      isSignIn = false;
                      Navigator.of(context).pushNamed('login');
                    },
                  )
                : ListTile(
                    title: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Droid',
                      ),
                    ),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      Navigator.of(context).pushNamed('login');
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
