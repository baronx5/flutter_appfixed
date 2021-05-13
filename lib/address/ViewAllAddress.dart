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
          'اختر العنوان المناسب',
          style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          SizedBox(
            height: 200,
            child: Image.network('https://media.istockphoto.com/vectors/quarantine-coronavirus-epidemic-free-delivery-man-in-a-protective-vector-id1214019831?k=6&m=1214019831&s=612x612&w=0&h=U1ZweEl62C9nZRwdv8JV7MgA-36d6eaUMf88yW9soHY='),
          ),
          FutureBuilder<List<Address>>(
              future: getAddressData(user.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return new Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Row(
                                    children: [
                                      Text(snapshot.data[index].area,style: TextStyle(fontFamily: 'Droid', fontSize: 14),),
                                      Text(" ق " + snapshot.data[index].block,style: TextStyle(fontFamily: 'Droid', fontSize: 14),),
                                      Text(" ش " +snapshot.data[index].street,style: TextStyle(fontFamily: 'Droid', fontSize: 14),),
                                      Text(" ج " +snapshot.data[index].jada,style: TextStyle(fontFamily: 'Droid', fontSize: 14),),
                                      Text(" د " +snapshot.data[index].floor,style: TextStyle(fontFamily: 'Droid', fontSize: 14),),
                                      Text(" م " +snapshot.data[index].houseNumber,style: TextStyle(fontFamily: 'Droid', fontSize: 14),),
                                    ],
                                  ),
                                  leading: Icon(Icons.location_city),
                                  trailing: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditAddress(user)),
                                    );
                                  },
                                ),
                                Divider()
                              ],
                            ));
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              }),
          SizedBox(
            height: 50,
            child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(primary: Colors.orange,
                ),
                child: Text('اضف عنوان جديد', style: TextStyle(fontFamily: 'Droid', fontSize: 16),)),
          )
        ],
      )
    );
  }
}
