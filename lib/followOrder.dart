import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'dart:convert';
import 'apiResponse.dart';


class FollowOrder extends StatefulWidget {


  @override
  _FollowOrderState createState() => _FollowOrderState();
}

class _FollowOrderState extends State<FollowOrder> {
  User user;
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

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    bool order = false;
    getOrderLevelData(user.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'متابعة الطلب',
          style: TextStyle(
              fontFamily: 'Droid', fontSize: 18, color: Colors.black54),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: size.width * 0.7,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Text('متوقع وصول الطلب خلال ٦٠ دقيقة', style: TextStyle(fontFamily: 'Droid', fontSize: 16),),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    child: Text('تم استقبال طلبك',style: TextStyle(fontFamily: 'Droid'),),
                  ),
                  Container(
                    height: 77,
                    width: 77,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200]
                    ),
                    child: order != false ?  Icon(Icons.file_download_done,color: Colors.orange,) : Icon(Icons.file_download_done,color: Colors.grey,) ,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    child: Text(' '),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 33,
                    width: 3,
                    color: Colors.grey[200],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    child: Text('جاري تحضير الطلب',style: TextStyle(fontFamily: 'Droid'),),
                  ),
                  Container(
                    height: 77,
                    width: 77,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200]
                    ),
                    child: Icon(Icons.no_food,color: Colors.orange,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    child: Text(' '),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 33,
                    width: 3,
                    color: Colors.grey[200],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    child: Text('جاري توصيل الطلب',style: TextStyle(fontFamily: 'Droid'),),
                  ),
                  Container(
                    height: 77,
                    width: 77,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200]
                    ),
                    child: Icon(Icons.delivery_dining,color: Colors.orange,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    child: Text(' '),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 33,
                    width: 3,
                    color: Colors.grey[200],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    child: Text('تم استلام الطلب',style: TextStyle(fontFamily: 'Droid'),),
                  ),
                  Container(
                    height: 77,
                    width: 77,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200]
                    ),
                    child: Icon(Icons.done,color: Colors.orange,),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              ElevatedButton(onPressed: (){}, child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('تاكيد وصول الطلب', style: TextStyle(fontFamily: 'Droid',fontSize: 16),),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                elevation: 0.0
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
