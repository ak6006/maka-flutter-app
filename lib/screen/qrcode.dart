import 'package:flutter/material.dart';
import 'package:maka/screen/homepage.dart';

class QrCode extends StatefulWidget {
  String qr;
  // String val;
  QrCode({this.qr});

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      body: Container(
        // height: MediaQuery.of(context).size.height,
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
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Center(
                      child: Image(
                        height: 250,
                        image: AssetImage('assets/images/lg2.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(left: 70),
                color: const Color.fromRGBO(0, 51, 94, 1),
                width: 190,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 1),
                  child: Text('${widget.qr}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'beIN',
                      )),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 10.0),
              ),
              Container(
                height: 40,
                width: 160,
                child: new FlatButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyHomePage()),
                    // );
                    Navigator.pop(context);
                  },
                  color: Color.fromRGBO(179, 0, 34, 1),
                  child: new Text(
                    'رجوع',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
