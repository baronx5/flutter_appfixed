import 'package:flutter/material.dart';
import 'package:flutter_appfixed/apiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'dart:convert';

class AddAddress extends StatefulWidget {
  final Function() notifyParent;

  const AddAddress({Key key, @required this.notifyParent}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  User user = User();
  Address address = Address();
  final addressForm = GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user') != null) {
      user = User.fromJson(jsonDecode(preferences.getString('user')));
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  void _showDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "خطأ",
            style: TextStyle(
                fontFamily: 'Droid', fontSize: 22, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          content: new Text(
            msg,
            style: TextStyle(
                fontFamily: 'Droid', fontSize: 18, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            new TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red, primary: Colors.white),
              child: Center(
                  child: new Text(
                "اعاده المحاولة",
                style: TextStyle(
                    fontFamily: 'Droid', fontSize: 16, color: Colors.white),
              )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اضافة عنوان جديد',
          style: TextStyle(fontFamily: 'Droid', color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Center(
        child: Form(
            key: addressForm,
            child: Column(
              children: [
                Container(
                  width: 300,
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    maxLength: 8,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: 'اسم المنطقة',
                        hintStyle: TextStyle(
                          fontFamily: 'Droid',
                        )),
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'ادخل  اسم المنطقة';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      address.area = value;
                    },
                  ),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      maxLength: 20,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: 'رقم القطعة',
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم القطعة';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address.block = value;
                      }),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      maxLength: 30,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: 'رقم الشارع',
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم الشارع';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address.street = value;
                      }),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      maxLength: 30,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: 'رقم المنزل',
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم المنزل';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address.houseNumber = value;
                      }),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      maxLength: 30,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: 'رقم الجادة',
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم الجادة';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address.jada = value;
                      }),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                      textDirection: TextDirection.rtl,
                      maxLength: 30,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: 'الدور',
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم الدور';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address.floor = value;
                      }),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(20.0),
                      backgroundColor: Colors.black,
                    ),
                    child: Text('اضافة العنوان الجديد',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Droid',
                            fontSize: 16)),
                    onPressed: () async {
                      if (addressForm.currentState.validate()) {
                        addressForm.currentState.save();
                        user.address = address;
                        user.address.userId = user.id.toString();
                        var postAddress = await newAddress(user, context);
                        if (postAddress["status"] == "success") {
                          savePref(user);
                          widget.notifyParent();
                          Navigator.pop(context, true);
                        } else {
                          _showDialog(context, postAddress["msg"]);
                        }
                      }
                    })
              ],
            )),
      ),
    );
  }
}
