import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:maka/models/querybarcode.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'barcodescannr.dart';

class DashBoardPage extends StatefulWidget {
  //الصفحة الرئيسية
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  SharedPreferences logindata;
  String username;

  // static String _email;
  // static String _password;
  bool isValid;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  QueryBarCode queryBarCode;

  // static Future init() async {
  //   localStorage = await SharedPreferences.getInstance();
  // }

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

    return barcodeScanRes;
  }

  String _textSelect(String str) {
    str = str.replaceAll('[', '');
    str = str.replaceAll(']', '');

    return str;
  }

  bool showSpinner = false;

  @override
  void initState() {
    //super.initState();
    showSpinner = false;
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('_name');
    });
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),

      //SingleChildScrollView
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
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
                    padding: new EdgeInsets.only(top: size.height * 0.05),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Flexible(
                          child: Hero(
                            tag: 'logo',
                            child: Container(
                              height: 190, // size.height * 0.2,
                              child: Center(
                                child: Image(
                                  height: 190, // size.height * 0.2,
                                  image: AssetImage('assets/images/lg2.jpg'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.05,
                        width: size.width * 0.08,
                        child: new IconButton(
                          onPressed: () {
                            // clearfun();

                            /// LOGOUT BUTTONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
                            Navigator.pushReplacementNamed(
                                context, '/MyHomePage');
                          },
                          color: Color.fromRGBO(0, 157, 68, 1),
                          icon: Icon(Icons.logout),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                    ],
                  ),

                  //---------------------------------
                  //-----------------------------
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // color: Color.fromRGBO(254, 88, 0, 1),
                    height: 50, //size.height * 0.07,
                    width: 220, //size.width * 0.7,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 5,
                        ),
                        Image(
                          height: size.height * 0.07,
                          image: AssetImage('assets/images/home.png'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Container(
                          // height: size.height * 0.07,
                          // width: size.width * 0.4,
                          child: new Text(
                            'الصفحة الرئيسية',
                            style: new TextStyle(
                                color: Color.fromRGBO(254, 88, 0, 1),
                                fontFamily: 'beIN',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 90),
                  ),

                  //------------------------------------------------------------------
                  //--------------------------------------------

                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 88, 0, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // color: Color.fromRGBO(254, 88, 0, 1),
                    //  height: 40, //size.height * 0.07,
                    // width: 220, //size.width * 0.7,
                    height: size.height * 0.06,
                    width: size.width * 0.7,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            // height: size.height * 0.07,
                            // width: size.width * 0.4,
                            child: new FlatButton.icon(
                              icon: Container(
                                // margin: EdgeInsets.only(left: 30),
                                // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Image.asset('assets/images/arrow.png'),
                              ),
                              label: Container(
                                width: size.width * 0.45,
                                // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(size.width * 0.07,
                                      0, size.width * 0.01, 0),
                                  child: Text(
                                    'رمز الاستجابة السريعة',
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'beIN',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                var brcode = await scanBarcodeNormal();

                                // setState(() {
                                //   showSpinner = true;
                                // });

                                //----------------------------
                                dynamic result =
                                    await databaseHelper.getData(brcode);
                                // .whenComplete(() {
                                //   if (databaseHelper.codest != 200) {
                                //     // _showDialog();
                                //     // msgStatus = 'Check email or password';
                                //     // print(msgStatus);
                                //   } else {
                                //     // _showDialog();
                                //     Navigator.pushReplacementNamed(
                                //         context, '/dashboard');
                                //   }
                                // });

                                //----------------------------

                                // print('$brcode');
                                // print('${result}');
                                // setState(() {
                                //   showSpinner = false;
                                // });
                                if (result == '') {
                                  return;
                                } else {
                                  // setState(() {
                                  //   showSpinner = false;
                                  // });

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
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //---------------------------------------------
                  //---------------------------------------------------
                  new Padding(
                    padding: new EdgeInsets.only(top: size.height * 0.05),
                  ),

                  //-------------------------------
                  //---------------------------------------

                  //-----------------------------
                  //--------------------------

                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 88, 0, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // color: Color.fromRGBO(254, 88, 0, 1),
                    //height: 40, //size.height * 0.07,
                    //  width: 220, //size.width * 0.7,
                    height: size.height * 0.06,
                    width: size.width * 0.7,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            // height: size.height * 0.07,
                            width: size.width * 0.35,
                            child: new FlatButton.icon(
                              label: Container(
                                //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                width: size.width * 0.45,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(size.width * 0.2,
                                      0, size.width * 0.01, 0),
                                  child: Text(
                                    'عربات النقل',
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
                                // margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                                child: Image.asset('assets/images/van.png'),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/vinpage');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Padding(
                    padding: new EdgeInsets.only(top: size.height * 0.05),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 88, 0, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // color: Color.fromRGBO(254, 88, 0, 1),
                    //height: 40, //size.height * 0.07,
                    //  width: 220, //size.width * 0.7,
                    height: size.height * 0.06,
                    width: size.width * 0.7,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            // height: size.height * 0.07,
                            width: size.width * 0.35,
                            child: new FlatButton.icon(
                              label: Container(
                                //margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                width: size.width * 0.45,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(size.width * 0.2,
                                      0, size.width * 0.01, 0),
                                  child: Text(
                                    'اجمالي الناتج',
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
                                // margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                                child: Image.asset('assets/images/van.png'),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/total');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Padding(
                    padding: new EdgeInsets.only(top: size.height * 0.05),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  clearfun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
