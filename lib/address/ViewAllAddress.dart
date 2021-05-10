import 'package:flutter/material.dart';
import 'package:flutter_appfixed/apiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_appfixed/Models/user.dart';
import 'package:flutter_appfixed/address/editAddress.dart';

class ViewAllAddress extends StatefulWidget {


  @override
  _ViewAllAddressState createState() => _ViewAllAddressState();
}

class _ViewAllAddressState extends State<ViewAllAddress> {


  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'title',
          style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: FutureBuilder<List<Address>>(
          future: getAddressData(user.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].area),
                      leading: Icon(Icons.six_ft_apart),
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAddress(user)),
                        );
                      },
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
