import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:maka/models/querybarcode.dart';
import 'package:maka/screen/qrcode.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/password_text_field.dart';
import 'package:maka/utils/primary_text_field.dart';

import 'barcodescannr.dart';

class DashBoardPage extends StatefulWidget {

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  static String _email;
  static String _password;
  bool isValid;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  QueryBarCode queryBarCode;

  Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
    return barcodeScanRes;
  }

  Future<String> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;
    // _scanBarcode = barcodeScanRes;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
    return barcodeScanRes;
  }

  String _textSelect(String str) {
    str = str.replaceAll('[', '');
    str = str.replaceAll(']', '');

    return str;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                padding: new EdgeInsets.only(top: size.height*0.05),
              ),
              Row(
                children: <Widget>[
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
                          height: size.height*0.2,
                          child: Center(
                            child: Image(
                              height: size.height*0.2,
                              image: AssetImage('assets/images/lg2.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: size.height*0.05,
                    width: size.width*0.08,
                    child: new IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/MyHomePage');
                      },
                      color: Color.fromRGBO(0, 157, 68, 1),
                      icon: Icon(Icons.save),
                    ),
                  ),
                  // Container(
                  //   width: 50,
                  //   height: 50,
                  //   // color: Color.fromRGBO(0, 51, 94, 1),
                  //   decoration: new BoxDecoration(
                  //     borderRadius: new BorderRadius.circular(16.0),
                  //     color: Colors.blue[600],
                  //   ),
                  //   child: Flexible(
                  //     child: Hero(
                  //       tag: 'logo',
                  //       child: Container(
                  //         height: 180.0,
                  //         child: Center(
                  //           child: Image(
                  //             height: 250,
                  //             image: AssetImage('assets/images/logout2.png'),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width:size.width*0.04,
                  ),
                ],
              ),
              Container(
                height:size.height*0.13,
                width: size.width*0.6,
                child: Container(
                  color: Color.fromRGBO(2, 36, 67, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          new Text(
                            'الصفحة الرئيسية',
                            style: new TextStyle(
                              color: Colors.white,
                              fontFamily: 'beIN',
                              fontSize: 18,
                            ),
                          ),
                          new Text(
                            'Dash Board',
                            style: new TextStyle(
                                color: Colors.white,
                                fontFamily: 'beIN',
                                fontSize: 18),
                          ),
                        ],
                      ),
                      Image(
                        height: size.height*0.06,
                        image: AssetImage('assets/images/Home-Icon.png'),
                      ),
                    ],
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: size.height*0.08),
              ),
              Container(
                height: size.height*0.06,
                width: size.width*0.5,
                child: new FlatButton(
                  onPressed: () async {
                    var brcode = await scanBarcodeNormal();

                    //----------------------------
                    dynamic result = await databaseHelper.getData(brcode);
                    //----------------------------------------
                    //     .whenComplete(() {
                    //   if (databaseHelper.codest != 200) {
                    //     _showDialog();
                    //     msgStatus = 'Check email or password';
                    //     print(msgStatus);
                    //   } else {
                    //     // _showDialog();
                    //     Navigator.pushReplacementNamed(
                    //         context, '/dashboard');
                    //   }
                    // });

                    //----------------------------

                    print('$brcode');
                    print('${result}');
                    if (result == '[]') return;

                    String output = _textSelect(result);

                    queryBarCode = queryBarCodeFromJson(output);
                    //  print(databaseEncode);
                    print(queryBarCode.customerName);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BarCodePage(
                                queryBarCode: queryBarCode,
                              )),
                    );
                    // for (QueryBarCode f in queryBarCode) {
                    //   print(f.customerName);
                    // }
                  },
                  color: Color.fromRGBO(179, 0, 34, 1),
                  child: new Text(
                    ' Bar Code Scanner',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: size.height*0.05),
              ),
              Container(
                height: size.height*0.06,
                width: size.width*0.5,
                child: new FlatButton(
                  onPressed: () {},
                  color: Color.fromRGBO(0, 157, 68, 1),
                  child: new Text(
                    'عربات النقل',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: size.height*0.05),
              ),
              Container(
                height: size.height*0.06,
                width: size.width*0.5,
                child: new FlatButton(
                  onPressed: () async {
                    var ss = await scanQR();
                    // print('ddddddddddddd $ss');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QrCode(
                                qr: ss,
                              )),
                    );
                  },
                  color: Color.fromRGBO(174, 0, 145, 1),
                  child: new Text(
                    'QR Code',
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
