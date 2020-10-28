import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:maka/models/querybarcode.dart';

import 'package:maka/screen/addOrder.dart';

import 'package:maka/screen/barcodescannr.dart';
import 'package:maka/screen/dashboard.dart';

import 'package:maka/screen/homepage.dart';
import 'package:maka/screen/manualscan.dart';
import 'package:maka/screen/mlkit.dart';

import 'package:maka/utils/animation.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/slideAnimations.dart';
import 'package:maka/utils/speech.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanDashBoardScreen extends StatefulWidget {
  //الصفحة الرئيسية
  @override
  _ScanDashBoardScreenState createState() => _ScanDashBoardScreenState();
}

class _ScanDashBoardScreenState extends State<ScanDashBoardScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  QueryBarCode queryBarCode;

  String _textSelect(String str) {
    str = str.replaceAll('[', '');
    str = str.replaceAll(']', '');

    return str;
  }

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

  bool showSpinner = false;

  @override
  void initState() {
    // blocData = DataBloc();
    super.initState();
    showSpinner = false;
    //  initial();
  }

  Widget build(BuildContext context) {
    // currentcontext = context;
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
                  //  new Container(child: new Image.memory(image)),
                  new Padding(
                    padding: new EdgeInsets.only(top: size.height * 0.12),
                  ),

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
                                'فحص شكارة بالسريال',
                                style: new TextStyle(
                                    color: Color.fromRGBO(254, 88, 0, 1),
                                    fontFamily: 'beIN',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(left: size.width * 0.05),
                      //   height: size.height * 0.05,
                      //   width: size.width * 0.08,
                      //   child: new IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MyCustomRoute(builder: (context) => MyHomePage()),
                      //       );
                      //     },
                      //     color: Color.fromRGBO(0, 157, 68, 1),
                      //     icon: Icon(Icons.logout),
                      //   ),
                      // ),
                    ],
                  ),

                  Expanded(
                    child: Container(
                      child: ListView(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          // Container(
                          //   width: 40,
                          //   height: 40,
                          //   alignment: Alignment.center,
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       BoxShadow(
                          //           blurRadius: .26,
                          //           spreadRadius: level * 1.5,
                          //           color: Colors.black.withOpacity(.05))
                          //     ],
                          //     color: Colors.white24,
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(10)),
                          //   ),
                          //   child: IconButton(
                          //       icon: Icon(Icons.mic, color: Colors.white),
                          //       onPressed: () {
                          //         speechcontext = context;

                          //         !hasSpeech || speech.isListening
                          //             ? null
                          //             : startListening();
                          //       }),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var result1 =
                                      await Connectivity().checkConnectivity();
                                  if (result1 == ConnectivityResult.none) {
                                    alertDialog(
                                        DialogType.ERROR,
                                        context,
                                        'خطاء في الاتصال',
                                        'لا يوجد اتصال بالسرفر',
                                        Icons.cancel,
                                        Colors.red);
                                  } else {
                                    var brcode = await scanBarcodeNormal();
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    dynamic result =
                                        await databaseHelper.getData(brcode);
                                    if (result == '') {
                                      alertDialog(
                                          DialogType.ERROR,
                                          context,
                                          'خطاء في السريال ',
                                          'هذه السريال ليس لمكة هاي فيد',
                                          Icons.cancel,
                                          Colors.red);
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      return;
                                    }

                                    String output = _textSelect(result);
                                    queryBarCode = queryBarCodeFromJson(output);
                                    print(queryBarCode.customerName);
                                    setState(() {
                                      showSpinner = false;
                                    });

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
                                            'فحص كاميرا الهاتف',
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
                                  Navigator.push(context,
                                      SlideLeftRoute(page: ManualScanScreen()));
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
                                            'assets/images/recieved.png',
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.only(
                                          //     left: size.width * 0.02),
                                          child: Text(
                                            'ادخال يدوي للسريال',
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
                          SizedBox(
                            height: 30,
                          ),

                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  SlideLeftRoute(
                                      page: TextrecognetionScreen()));
                              //return;
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 95, right: 95),
                              height: size.height * 0.2,
                              width: size.width * 0.42,
                              child: Card(
                                elevation: 20,
                                color: Colors.deepOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 70,
                                      child: Image.asset(
                                        'assets/images/qrcode.png',
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                    Container(
                                      // margin: EdgeInsets.only(
                                      //     left: size.width * 0.02),
                                      child: Text(
                                        'مسح نصي كاميرا',
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

                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
                          new Padding(
                            padding:
                                new EdgeInsets.only(top: size.height * 0.08),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 70.0, right: 70),
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(254, 88, 0, 1),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            height: 40,
                            width: 120,
                            child: new FlatButton(
                              onPressed: () {
                                Navigator.push(context,
                                    SlideLeftRoute(page: DashBoardPage()));
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

                          //------------------------------------------------------
                          //===================================================================

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

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
        //   }
        //   return Container();
        // }),
      ),
    );
  }

  Container buildAgentCustomerName(Size size, String name) {
    return Container(
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
              child: Image.asset('assets/images/customer.png'),
            ),
            Text(
              //'عربات النقل'
              name,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'beIN',
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  clearfun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
