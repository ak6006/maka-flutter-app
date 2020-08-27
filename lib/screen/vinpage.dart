import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:maka/utils/password_text_field.dart';
import 'package:maka/utils/primary_text_field.dart';

class VinPage extends StatefulWidget {
  @override
  _VinPageState createState() => _VinPageState();
}

class _VinPageState extends State<VinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),

      //SingleChildScrollView
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              Container(
                // color: Color.fromRGBO(0, 51, 94, 1),
                // decoration: new BoxDecoration(
                //   borderRadius: new BorderRadius.circular(16.0),
                //   color: Colors.green,
                // ),
                child: Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 220.0,
                      child: Center(
                        child: Image(
                          height: 250,
                          image: AssetImage('assets/images/lg2.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 190,
                child: Container(
                  alignment: Alignment.center,
                  color: Color.fromRGBO(2, 36, 67, 1),
                  child: new Text(
                    'عربات النقل',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 90.0),
              ),
              Container(
                height: 45,
                width: 200,
                child: new FlatButton(
                  onPressed: () {},
                  color: Color.fromRGBO(0, 157, 68, 1),
                  child: new Text(
                    ' وصول',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 40.0),
              ),
              Container(
                height: 45,
                width: 200,
                child: new FlatButton(
                  onPressed: () {},
                  color: Color.fromRGBO(179, 0, 34, 1),
                  child: new Text(
                    'مغادرة',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
