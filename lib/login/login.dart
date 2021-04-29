import 'package:flutter/material.dart';
import '../customWidgets/customAppBar.dart';


class LoginPage extends StatelessWidget {
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
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)
                  ),
                  hintText: 'رقم الهاتف', hintStyle: TextStyle(fontFamily: 'Droid',)
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  hintText: 'الرقم السري', hintStyle: TextStyle(fontFamily: 'Droid',)
                ),
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(

              padding: EdgeInsets.all(20.0),
              color: Colors.black,
              child: Text('تسجيل الدخول',style: TextStyle(color: Colors.white,fontFamily: 'Droid', fontSize: 16)),
              onPressed: () {  }),
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
