import 'package:flutter/material.dart';
import 'package:flutter_appfixed/apiResponse.dart';
import 'package:flutter_appfixed/login//signup.dart';

class LoginPage extends StatefulWidget {

  // passing phone and password for login.
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phone;
  String password;
  final signInForm = GlobalKey<FormState>();

  void _showDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("خطأ", style: TextStyle(fontFamily: 'Droid',fontSize: 22, color: Colors.black54),textAlign: TextAlign.center,),
          content: new Text(msg, style: TextStyle(fontFamily: 'Droid',fontSize: 18, color: Colors.black54),textAlign: TextAlign.center,),
          actions: <Widget>[
            new TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  primary: Colors.white
              ),
              child: Center(child: new Text("اعاده المحاولة",style: TextStyle(fontFamily: 'Droid',fontSize: 16, color: Colors.white),)),
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
      //appBar: CustomAppBar(),
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 80,
            ),
            Image.network('https://flutterforweb.000webhostapp.com/resturant/logo.jpg', width: 150,),
            Text('تسجيل الدخول',style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'Droid')),
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
                            borderSide: BorderSide(
                              color: Colors.amber
                            ),
                          borderRadius: BorderRadius.circular(10.0)
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
                              borderSide: BorderSide(
                                  color: Colors.amber
                              ),
                              borderRadius: BorderRadius.circular(10.0)
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
              ],
            )),
            // ignore: deprecated_member_use
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(20.0),
                  backgroundColor: Colors.black,
                ),
              child: Text('تسجيل الدخول',style: TextStyle(color: Colors.white,fontFamily: 'Droid', fontSize: 16)),
              onPressed: () async {
                if(signInForm.currentState.validate()){
                  signInForm.currentState.save();
                  var response = await signIn(phone, password,context);
                  _showDialog(context, response);

                }
              }
              ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(20.0),
                backgroundColor: Colors.black,
              ),
              child: Text('انشاء حساب جديد',style: TextStyle(color: Colors.white,fontFamily: 'Droid', fontSize: 16)),
              onPressed: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                }
              ),
            Text('نسيت الرقم السري',style: TextStyle(color: Colors.black,fontFamily: 'Droid', fontSize: 16)),
            InkWell(child: Text('تسجيل لاحقاً',style: TextStyle(color: Colors.black,fontFamily: 'Droid', fontSize: 16)),onTap: (){
              Navigator.pushReplacementNamed(context, 'MyApp');
            },),
            SizedBox(
              height: 100,
            )
          ],
        )),
      ),
    );

  }

}
