import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:maka/screen/qrcode.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String _scanBarcode = 'Unknown';

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

    return barcodeScanRes;
  }

  @override
  void initState() {
    // showSpinner = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
              ),
              Container(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 190, //size.height * 0.20,
                    // width: 290,
                    child: Center(
                      child: Image(
                        height: 190, //size.height * 0.2,
                        image: AssetImage('assets/images/lg2.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(254, 88, 0, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                // color: Color.fromRGBO(254, 88, 0, 1),
                height: size.height * 0.06, //,40,
                width: size.width * 0.7, //,220,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        // height: size.height * 0.07,
                        // width: size.width * 0.4,
                        child: new FlatButton.icon(
                          label: Container(
                            width: size.width * 0.5, //dhgdhdhdhdhdhdhdhdhdhdhdh
                            //margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Container(
                              //width: size.width * 0.5,
                              margin: EdgeInsets.fromLTRB(
                                  size.width * 0.13, 0, size.width * 0.01, 0),
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'beIN',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          icon: Container(
                            // margin: EdgeInsets.symmetric(
                            //     horizontal: size.width * 0.03),
                            // margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: Image.asset(
                              'assets/images/log.png',
                              height: 24,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // new Padding(
              //   padding: EdgeInsets.only(top: size.height * 0.08),
              // ),
              new Padding(
                padding: new EdgeInsets.only(top: size.height * 0.05),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(254, 88, 0, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                // color: Color.fromRGBO(254, 88, 0, 1),
                height: size.height * 0.06, //,40,
                width: size.width * 0.7, //height: 40,
                // width: 220,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        // height: size.height * 0.07,
                        // width: size.width * 0.4,
                        child: new FlatButton.icon(
                          label: Container(
                            width: size.width * 0.5, //dhdhdhdhdhdhdhdhdhhdhdhd
                            // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  size.width * 0.1, 0, size.width * 0.01, 0),
                              child: Text(
                                'انشاء حساب جديد',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'beIN',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          icon: Container(
                            //  margin: EdgeInsets.only(left: 30),
                            // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Image.asset(
                              'assets/images/logs.png',
                              height: 25,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/register');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: size.height * 0.06),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(254, 88, 0, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                // color: Color.fromRGBO(254, 88, 0, 1),
                height: size.height * 0.06,
                width: size.width * 0.7, //height: 40,
                //  width: 220,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        // height: size.height * 0.06,
                        // width: size.width * 0.55,
                        // height: size.height * 0.07,
                        // width: size.width * 0.4,
                        child: new FlatButton.icon(
                          label: Container(
                            // margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            width: size.width * 0.5,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  size.width * 0.06, 0, size.width * 0.01, 0),
                              child: Text(
                                'فحص الكيو ار كود',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'beIN',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          icon: Container(
                            //  margin: EdgeInsets.only(left: 30),
                            //margin: EdgeInsets.fromLTRB(15, 0, 5, 0),
                            child: Image.asset(
                              'assets/images/arrow.png',
                              height: 25,
                            ),
                          ),
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
