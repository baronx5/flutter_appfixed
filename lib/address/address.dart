import 'package:flutter/material.dart';
import 'package:flutter_appfixed/apiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'dart:convert';

class AddAddress extends StatefulWidget {
  final Function notifyCheckoutPage;
  final Function notifyViewAllAddress;
  const AddAddress({Key key, this.notifyCheckoutPage, this.notifyViewAllAddress}) : super(key: key);

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
      body: ListView(children: [
        Directionality(textDirection: TextDirection.rtl, child: Form(
            key: addressForm,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.network('https://freesvg.org/img/1392496432.png'),
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  //color: Colors.white,
                  alignment: Alignment.center,
                  child: Text('اضف عنوانك الحالي',style: TextStyle(fontSize: 18, fontFamily: 'Droid'),),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  //color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          maxLength: 8,
                          decoration: InputDecoration(
                              hintText: ' المنطقة',
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
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 20,
                            decoration: InputDecoration(
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
                    ],),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  //color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 30,
                            decoration: InputDecoration(
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
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 30,
                            decoration: InputDecoration(
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
                    ],),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  //color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 30,
                            decoration: InputDecoration(
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
                        width: 150,
                        child: TextFormField(
                            textDirection: TextDirection.rtl,
                            maxLength: 30,
                            decoration: InputDecoration(
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
                    ],),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 20)),

                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(20.0),
                      backgroundColor: Colors.orange[400],
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
                          widget.notifyCheckoutPage();
                          if(widget.notifyViewAllAddress != null){
                            print("view all address refresh function invoked");
                            widget.notifyViewAllAddress();
                          }
                          Navigator.pop(context, true);
                        } else {
                          _showDialog(context, postAddress["msg"]);
                        }
                      }
                    })
              ],
            )))
      ],),
    );
  }
}
