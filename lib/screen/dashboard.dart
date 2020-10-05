import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:maka/models/dropdownlist.dart';
import 'package:maka/models/orderQuntitySum.dart';
import 'package:maka/models/productlist.dart';
import 'package:maka/models/querybarcode.dart';
import 'package:maka/screen/FeedPrices.dart';
import 'package:maka/screen/addOrder.dart';
import 'package:maka/screen/addvan.dart';
import 'package:maka/screen/filterScreen.dart';
import 'package:maka/screen/homepage.dart';
import 'package:maka/screen/qrcode.dart';
import 'package:maka/screen/vinpage.dart';
import 'package:maka/utils/animation.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/speech.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'barcodescannr.dart';
import 'orderQuantityScreen.dart';

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
  List<OrderQuantitySumQuery> orderquantitysumquery;
  //List<ProductList> productlist;

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
    //  initial();
  }

  void initial() async {
    // logindata = await SharedPreferences.getInstance();
    // setState(() {
    //   username = logindata.getString('_name');
    // });
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
                    padding: new EdgeInsets.only(top: size.height * 0.12),
                  ),
                  // Container(
                  //   child: Flexible(
                  //     child: Hero(
                  //       tag: 'logo',
                  //       child: Container(
                  //         height: 190, // size.height * 0.2,
                  //         child: Center(
                  //           child: Image(
                  //             height: 190, // size.height * 0.2,
                  //             image: AssetImage('assets/images/lg2.jpg'),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // SizedBox(
                  //   width: size.width * 0.04,
                  // ),

                  //===================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.05),
                        height: size.height * 0.05,
                        width: size.width * 0.08,
                        child: new IconButton(
                          onPressed: () {
                            // clearfun();

                            /// LOGOUT BUTTONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
                            // Navigator.pushReplacementNamed(
                            //     context, '/MyHomePage');
                            Navigator.push(
                              context,
                              MyCustomRoute(builder: (context) => MyHomePage()),
                            );
                          },
                          color: Color.fromRGBO(0, 157, 68, 1),
                          icon: Icon(Icons.logout),
                        ),
                      ),
                    ],
                  ),
                  // new Padding(
                  //   padding: new EdgeInsets.only(top: size.height * 0.06),
                  // ),
                  Expanded(
                    child: Container(
                      child: ListView(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: .26,
                                    spreadRadius: level * 1.5,
                                    color: Colors.black.withOpacity(.05))
                              ],
                              color: Colors.white24,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: IconButton(
                                icon: Icon(Icons.mic, color: Colors.white),
                                onPressed: () {
                                  speechcontext = context;

                                  !hasSpeech || speech.isListening
                                      ? null
                                      : startListening();
                                }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // var brcode = await scanBarcodeNormal();
                                  dynamic result =
                                      await databaseHelper.getData('88');
                                  if (result == '') {
                                    return;
                                  } else {
                                    String output = _textSelect(result);
                                    queryBarCode = queryBarCodeFromJson(output);
                                    print(queryBarCode.customerName);

                                    Navigator.push(
                                      context,
                                      MyCustomRoute(
                                          builder: (context) => BarCodePage(
                                                queryBarCode: queryBarCode,
                                              )),
                                    );
                                  }
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.42,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/images/arrow.png'),
                                        ),
                                        Center(
                                          child: Text(
                                            'فحص شكارة بالسيريال',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontFamily: 'beIN',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) => AddOrderScreen()),
                                  );
                                  //return;
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.42,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/images/recieved.png'),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.only(
                                          //     left: size.width * 0.02),
                                          child: Text(
                                            'اضافة طلبية جديدة',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontFamily: 'beIN',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
                          new Padding(
                            padding:
                                new EdgeInsets.only(top: size.height * 0.01),
                          ),

                          //------------------------------------------------------
                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // Navigator.pushReplacementNamed(
                                  //     context, '/vinpage');
                                  Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) => VinPage()),
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.42,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/images/customer.png'),
                                        ),
                                        Text(
                                          //'عربات النقل'
                                          agentCustomerName,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'beIN',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // var brcode = await scanBarcodeNormal();
                                  // dynamic result = await databaseHelper.getData(brcode);
                                  // if (result == '') {
                                  //   return;
                                  // } else {
                                  //   String output = _textSelect(result);
                                  //   queryBarCode = queryBarCodeFromJson(output);
                                  //   print(queryBarCode.customerName);

                                  Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) =>
                                            FilterScreenPage()),
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.42,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/images/query.png'),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 0, size.width * 0.04, 0),
                                          // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Text(
                                            'استعلام مشتريات وكيل',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontFamily: 'beIN',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
                          new Padding(
                            padding:
                                new EdgeInsets.only(top: size.height * 0.01),
                          ),
                          //============================================================

                          Row(
                            /// اسعار الاعلاف اليوم
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // Navigator.pushReplacementNamed(
                                  //     context, '/FeedPrices');
                                  Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) => FeedPrices()),
                                  );

                                  /// اسعار الاعلاف اليوم
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.42,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/images/price.png'),
                                        ),
                                        Text(
                                          'اسعار الاعلاف اليوم',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'beIN',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var ss = await scanQR();
                                  // print('ddddddddddddd $ss');
                                  Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) => QrCode(
                                              qr: ss,
                                            )),
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.42,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/images/qrcode.png'),
                                        ),
                                        Container(
                                          // margin:
                                          //     EdgeInsets.only(right: size.width * 0.04),
                                          child: Text(
                                            'فحص الكيو ار كود',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontFamily: 'beIN',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
                          Row(
                            /// اسعار الاعلاف اليوم
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) =>
                                            AddVanScreen()), //FilterScreenPage()),
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.42,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/images/truck.png'),
                                        ),
                                        Text(
                                          'اضافة عربية نقل',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'beIN',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var ss = await scanQR();
                                  // print('ddddddddddddd $ss');
                                  Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) => QrCode(
                                              qr: ss,
                                            )),
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.42,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/images/arrow.png'),
                                        ),
                                        Container(
                                          // margin:
                                          //     EdgeInsets.only(right: size.width * 0.04),
                                          child: Text(
                                            'فحص الكيو ار كود',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontFamily: 'beIN',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
                        ],
                      ),
                    ),
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
