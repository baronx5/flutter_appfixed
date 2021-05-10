import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/user.dart';

class EditAddress extends StatelessWidget {
  User user;
  EditAddress(this.user);
  @override
  Widget build(BuildContext context) {
    print(user.email);
    return Scaffold(
      body: Center(
        child: Text(user.email, style: TextStyle(color: Colors.black54),),
      ),
    );
  }
}
