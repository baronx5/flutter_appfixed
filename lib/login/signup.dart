import 'package:flutter/material.dart';
import '/apiResponse.dart';


class SignUpPage extends StatelessWidget {

  String phone;
  String password;
  String email;
  final signInForm = GlobalKey<FormState>();
  void _showDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("خطأ", style: TextStyle(fontFamily: 'Droid',fontSize: 22, color: Colors.black54),textAlign: TextAlign.center,),
          content: new Text(msg, style: TextStyle(fontFamily: 'Droid',fontSize: 18, color: Colors.black54),textAlign: TextAlign.center,),
          actions: <Widget>[
            new FlatButton(
              child: Center(child: new Text("اعاده المحاولة",style: TextStyle(fontFamily: 'Droid',fontSize: 16, color: Colors.white),)),
              color: Colors.lightGreen,
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
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 100,
            ),
            Image.network('https://flutterforweb.000webhostapp.com/resturant/logo.jpg', width: 150,),
            Text('تسجيل حساب جديد',style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Droid')),
            Form(
                key: signInForm,
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.phone,
                        maxLength: 8,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0)
                            ),
                            hintText: 'رقم الهاتف', hintStyle: TextStyle(fontFamily: 'Droid',)
                        ),
                        validator: (value){
                          if (value.isEmpty || value == null){
                            return 'ادخل رقم الهاتف';
                          } return null;
                        },
                        onSaved: (value){
                          phone = value ;
                        },
                      ),
                    ),
                    Container(
                      width: 300,
                      child: TextFormField(
                          textDirection: TextDirection.rtl,
                          maxLength: 30,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              hintText: 'الرقم السري', hintStyle: TextStyle(fontFamily: 'Droid',)
                          ),
                          validator: (value){
                            if (value.isEmpty || value == null){
                              return 'ادخل الرقم السري';
                            } return null;
                          },
                          onSaved: (value){
                            password = value ;
                          }
                      ),
                    ),
                    Container(
                      width: 300,
                      child: TextFormField(
                          textDirection: TextDirection.rtl,
                          maxLength: 30,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              hintText: 'البريد الالكتروني', hintStyle: TextStyle(fontFamily: 'Droid',)
                          ),
                          validator: (value){
                            if (value.isEmpty || value == null){
                              return 'ادخل البريد الالكتروني';
                            } return null;
                          },
                          onSaved: (value){
                            email = value ;
                          }
                      ),
                    ),
                  ],
                )),
            // ignore: deprecated_member_use
            RaisedButton(
                padding: EdgeInsets.all(20.0),
                color: Colors.black,
                child: Text('تسجيل حساب جديد',style: TextStyle(color: Colors.white,fontFamily: 'Droid', fontSize: 16)),
                onPressed: () async {
                  if(signInForm.currentState.validate()){
                    signInForm.currentState.save();
                    var response = await signUp(phone, password,email, context);
                    _showDialog(context, response);

                  }
                }
            ),
            InkWell(child: Text('العودة',style: TextStyle(color: Colors.black,fontFamily: 'Droid', fontSize: 16)),onTap: (){
              Navigator.pop(context);
            },),
            SizedBox(
              height: 100,
            )
          ],
        )),
      ),
    );;
  }
}


