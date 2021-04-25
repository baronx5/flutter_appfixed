import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page'),),
      body: Center(
        child: InkWell(child: Text('Login Page here ....'),
        onTap: (){
          Navigator.pushNamed(context, 'MyApp');
        },),
      ),
    );
  }
}
