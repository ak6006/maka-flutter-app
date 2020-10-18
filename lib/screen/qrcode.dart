import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              Container(
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
              Expanded(
                child: Container(
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
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 0.0),
              ),
              Container(
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(254, 88, 0, 1),
                  borderRadius: BorderRadius.circular(60),
                ),
                height: 40,
                width: 160,
                child: new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Color.fromRGBO(254, 88, 0, 1),
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
