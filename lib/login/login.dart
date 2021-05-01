import 'package:flutter/material.dart';
import 'package:flutter_appfixed/apiresponse.dart';

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
          title: new Text("Alert!!"),
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1577670552647-6ce12a463e7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop)
          )
        ),
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 100,
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
                              borderRadius: BorderRadius.circular(25.0)
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
            RaisedButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.black,
              child: Text('تسجيل الدخول',style: TextStyle(color: Colors.white,fontFamily: 'Droid', fontSize: 16)),
              onPressed: () async {
                if(signInForm.currentState.validate()){
                  signInForm.currentState.save();
                  var response = await signIn(phone, password,context);
                  _showDialog(context, response);

                }
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
