import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/user.dart';

class CustomDrawer extends StatelessWidget {

  User user;
  CustomDrawer({this.user});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        //padding: EdgeInsets.zero,
        children: <Widget>[
          Expanded(child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user.name, style: TextStyle(color: Colors.orange),),
                accountEmail: Text("ashishrawat2911@gmail.com", style: TextStyle(color: Colors.orange)),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 40.0, color: Colors.orangeAccent),
                  ),
                ),
              ),
              ListTile(
                title: Text('متابعة الطلبات', style: TextStyle(fontSize: 16, fontFamily: 'Droid',),),
                leading: Icon(Icons.follow_the_signs),
                onTap: () {
                  Navigator.pushNamed(context, 'login');

                },
              ),
              Divider(),
              ListTile(
                title: Text('الدعم الفني', style: TextStyle(fontSize: 16, fontFamily: 'Droid',),),
                leading: Icon(Icons.support),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('الملاحظات والشكاوي', style: TextStyle(fontSize: 16, fontFamily: 'Droid',),),
                leading: Icon(Icons.fastfood),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('الاعدادات', style: TextStyle(fontSize: 16, fontFamily: 'Droid',),),
                leading: Icon(Icons.settings),
                onTap: () {},
              ),
              Divider(),
            ],
          )),

          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: ListTile(
              title: Text('تسجيل الخروج', style: TextStyle(fontSize: 16, fontFamily: 'Droid',),),
              leading: Icon(Icons.logout),
              onTap: () {},
            ),
          ),

        ],
      ),
    );
  }
}

