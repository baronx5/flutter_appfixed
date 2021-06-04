import 'package:flutter/material.dart';
import 'package:flutter_appfixed/address/address.dart';
import 'package:flutter_appfixed/apiResponse.dart';
import 'package:flutter_appfixed/Models/user.dart';
import 'package:flutter_appfixed/address/editAddress.dart';
import 'package:flutter_appfixed/customWidgets/AlertDialog.dart';

class ViewAllAddress extends StatefulWidget {
  final Function notifyCheckoutPage;
  final User user;

  const ViewAllAddress({Key key, this.notifyCheckoutPage, this.user})
      : super(key: key);

  @override
  _ViewAllAddressState createState() => _ViewAllAddressState(user: user);
}

class _ViewAllAddressState extends State<ViewAllAddress> {
  User user;
  Future<List<Address>> allAddress;

  _ViewAllAddressState({this.user});

  void refreshData() {
    setState(() {
      allAddress = getAddressData(widget.user.id);
    });
  }

  @override
  void initState() {
    allAddress = getAddressData(user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            SizedBox(
              child: Image(image: AssetImage('images/delivery.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                'قائمة العناوين الخاصة بك',
                style: TextStyle(fontSize: 18, fontFamily: 'Droid'),
              ),
            ),
            Container(
              color: Colors.white,
              child: FutureBuilder<List<Address>>(
                  future: allAddress,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              background: Container(
                                color: Colors.red,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  child: Text('حذف العنوان',style: TextStyle(fontFamily: 'Droid',color: Colors.white),),
                                ),
                              ),
                              onDismissed: (direction) {
                                setState(() {
                                  addressRemove(snapshot.data[index]);
                                  snapshot.data.removeAt(index);
                                  if(snapshot.data.length > 0){
                                    user.address = snapshot.data.last;
                                  }else {
                                    user.address = null;
                                  }
                                  savePref(user);
                                  widget.notifyCheckoutPage();
                                });
                              },
                              key: ValueKey<int>(snapshot.data[index].id),
                              child: new Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          snapshot.data[index].area,
                                          style: TextStyle(
                                              fontFamily: 'Droid',
                                              fontSize: 14),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              " ق " +
                                                  snapshot.data[index].block,
                                              style: TextStyle(
                                                  fontFamily: 'Droid',
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              " ش " +
                                                  snapshot.data[index].street,
                                              style: TextStyle(
                                                  fontFamily: 'Droid',
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              " ج " + snapshot.data[index].jada,
                                              style: TextStyle(
                                                  fontFamily: 'Droid',
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              " د " +
                                                  snapshot.data[index].floor,
                                              style: TextStyle(
                                                  fontFamily: 'Droid',
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              " م " +
                                                  snapshot
                                                      .data[index].houseNumber,
                                              style: TextStyle(
                                                  fontFamily: 'Droid',
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        leading: Icon(
                                            Icons.location_history_outlined),
                                        trailing:
                                            snapshot.data[index].userDefault
                                                ? Icon(
                                                    Icons.location_on,
                                                    color: Colors.orange,
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.all(0)),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditAddress(
                                                      address:
                                                          snapshot.data[index],
                                                      notifyCheckoutPage: widget
                                                          .notifyCheckoutPage,
                                                      user: widget.user,
                                                      notifyViewAllAddress:
                                                          refreshData,
                                                    )),
                                          );
                                        },
                                      ),
                                      Divider()
                                    ],
                                  )),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.orange,
                        )));
                  }),
            ),
            SizedBox(
              height: 60,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddAddress(
                                  notifyCheckoutPage: widget.notifyCheckoutPage,
                                  notifyViewAllAddress: refreshData,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange[400],
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text(
                    'اضف عنوان جديد',
                    style: TextStyle(fontFamily: 'Droid', fontSize: 16),
                  )),
            )
          ],
        ));
  }
}
