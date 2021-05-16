import 'package:flutter/material.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'package:flutter_appfixed/apiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditAddress extends StatefulWidget {
  final Address address;
  final Function notifyParent;
  final User user;
  const EditAddress({Key key, this.notifyParent, this.address, this.user}) : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {

  final addressForm = GlobalKey<FormState>();

  bool _valueR = false;
  int selectR = 0;

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
                        hintText: widget.address.area,
                        hintStyle: TextStyle(
                          fontFamily: 'Droid',
                        )),
                    initialValue: widget.address.area,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'ادخل  اسم المنطقة';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.address.area = value;
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
                          hintText: widget.address.block,
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      initialValue: widget.address.block,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم القطعة';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.address.block = value;
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
                          hintText: widget.address.street,
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      initialValue: widget.address.street,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم الشارع';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.address.street = value;
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
                          hintText: widget.address.houseNumber,
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      initialValue: widget.address.houseNumber,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم المنزل';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.address.houseNumber = value;
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
                          hintText: widget.address.jada,
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      initialValue: widget.address.jada,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم الجادة';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.address.jada = value;
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
                          hintStyle: TextStyle(
                            fontFamily: 'Droid',
                          )),
                      initialValue: widget.address.floor,
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'ادخل رقم الدور';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        widget.address.floor = value;
                      }),
                ),
                Container(
                    width: 300,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: CheckboxListTile(
                        title: Text(
                            "I dont know how to type arabic in this mf laptop"),
                        value: widget.address.userDefault,
                        onChanged: (value) {
                          setState(() {
                            widget.address.userDefault =
                                !widget.address.userDefault;
                          });
                        },
                      ),
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(20.0),
                      backgroundColor: Colors.black,
                    ),
                    child: Text('تعديل العنوان ',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Droid',
                            fontSize: 16)),
                    onPressed: () async {
                      if (addressForm.currentState.validate()) {
                        addressForm.currentState.save();
                        var postAddress =
                            await addressUpdate(widget.address, context);
                        if (postAddress["status"] == "success") {
                          // if the user made it as default address it will refresh the address in the checkout page
                          //otherwise it will not refresh
                          if(widget.address.userDefault){
                            widget.user.address = widget.address;
                            savePref(widget.user);
                            widget.notifyParent();
                          }
                          Navigator.pop(context);
                        } else {
                          _showDialog(context, postAddress["msg"]);
                        }
                      }
                    })
              ],
            )),
      ),
    );
    ;
  }
}
