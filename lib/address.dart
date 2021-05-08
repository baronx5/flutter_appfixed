import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافة عنوان جديد',style: TextStyle(fontFamily: 'Droid', color: Colors.black54),),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Center(child: Text('Address Page'),),
    );
  }
}

