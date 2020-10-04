import 'package:flutter/material.dart';
import 'package:maka/utils/primary_text_field.dart';

class AddVan extends StatefulWidget {
  @override
  _AddVanState createState() => _AddVanState();
}

class _AddVanState extends State<AddVan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 19),
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 140.0,
                        child: Center(
                          child: Image(
                            height: 250,
                            image: AssetImage('assets/images/lg2.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // padding: const EdgeInsets.only(left: 30),
                    width: 190,
                    alignment: Alignment.center,
                    color: Color.fromRGBO(254, 88, 0, 1),
                    child: new Text(
                      'اضافة عربية جديدة',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    PrimaryTextField(
                      label: ' رقم العربية',
                    ),
                    SizedBox(height: 20),
                    PrimaryTextField(
                      label: 'اسم السائق',
                    ),
                    SizedBox(height: 20),
                    PrimaryTextField(
                      label: 'موديل العربية',
                    ),
                    SizedBox(height: 20),
                    PrimaryTextField(
                      label: 'رقم التليفون',
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 100.0),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(254, 88, 0, 1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 40,
                    width: 120,
                    child: new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Color.fromRGBO(254, 88, 0, 1),
                      child: new Text(
                        'الغاء',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'beIN',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(254, 88, 0, 1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 40,
                    width: 120,
                    child: new FlatButton(
                      onPressed: () {},
                      color: Color.fromRGBO(254, 88, 0, 1),
                      child: new Text(
                        'تاكيد الطلب',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'beIN',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
