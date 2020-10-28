import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:maka/bloca/apiresponse.dart';
import 'package:maka/gift/giftDashBoard.dart';
import 'package:maka/models/orderQuntitySum.dart';
import 'package:maka/models/querybarcode.dart';
import 'package:maka/screen/FeedPrices.dart';
import 'package:maka/screen/addOrder.dart';
import 'package:maka/screen/addvan.dart';
import 'package:maka/screen/filterScreen.dart';
import 'package:maka/screen/homepage.dart';
import 'package:maka/screen/qrcode.dart';
import 'package:maka/screen/scandashboard.dart';
import 'package:maka/screen/vinpage.dart';
import 'package:maka/utils/animation.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/slideAnimations.dart';
import 'package:maka/utils/speech.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'login.dart';

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

  // Future<String> scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         "#ff6666", "Cancel", true, ScanMode.BARCODE);
  //     // print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }

  //   return barcodeScanRes;
  // }

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

  Timer _timer;
  @override
  void initState() {
    // blocData = DataBloc();
    super.initState();
    showSpinner = false;
    //  initial();
    _initializeTimer();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 6), (_) => _logOutUser());
    //print('intializeTimer');
  }

  void _logOutUser() {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (BuildContext context) => LogIn()));

    // Navigator.of(ContextClass.CONTEXT)
    //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => true);

    Navigator.pushReplacementNamed(context, '/MyHomePage');

    // Log out the user if they're logged in, then cancel the timer.
    // You'll have to make sure to cancel the timer if the user manually logs out
    //   and to call _initializeTimer once the user logs in
    //print('timer execution');
    _timer.cancel();
  }

  // You'll probably want to wrap this function in a debounce
  void _handleUserInteraction([_]) {
    //print('interaction');
    if (!_timer.isActive) {
      // This means the user has been logged out
      return;
    }

    _timer.cancel();
    _initializeTimer();
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

                          //rowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onPanDown: _handleUserInteraction,
                                onScaleStart: _handleUserInteraction,
                                onTap: () async {
                                  _handleUserInteraction();
                                  Navigator.push(
                                      context,
                                      SlideLeftRoute(
                                          page: ScanDashBoardScreen()));
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
                              IgnorePointer(
                                ignoring: !customerRoles,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onPanDown: _handleUserInteraction,
                                  onScaleStart: _handleUserInteraction,
                                  onTap: () async {
                                    _handleUserInteraction();
                                    Navigator.push(context,
                                        SlideLeftRoute(page: AddOrderScreen()));
                                    //return;
                                  },
                                  child: Container(
                                    height: size.height * 0.2,
                                    width: size.width * 0.42,
                                    child: Card(
                                      elevation: 20,
                                      color: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                                              color: customerRoles
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Colors.white54,
                                            ),
                                          ),
                                          Container(
                                            // margin: EdgeInsets.only(
                                            //     left: size.width * 0.02),
                                            child: Text(
                                              'اضافة طلبية جديدة',
                                              style: TextStyle(
                                                  color: customerRoles
                                                      ? Color.fromRGBO(
                                                          255, 255, 255, 1)
                                                      : Colors.white54,
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
                              IgnorePointer(
                                ignoring: !customerRoles,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onPanDown: _handleUserInteraction,
                                  onScaleStart: _handleUserInteraction,
                                  onTap: () async {
                                    _handleUserInteraction();
                                    Navigator.push(context,
                                        SlideLeftRoute(page: VinPage()));
                                  },
                                  child: Container(
                                    height: size.height * 0.2,
                                    width: size.width * 0.42,
                                    child: Card(
                                      elevation: 20,
                                      color: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 70,
                                            child: Image.asset(
                                              'assets/images/customer.png',
                                              color: customerRoles
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Colors.white54,
                                            ),
                                          ),
                                          Text(
                                            snapshotdata.data.status ==
                                                    Status.COMPLETED
                                                ? agentCustomerName
                                                //'مصر الفيوم'
                                                : 'تحميل...',
                                            style: TextStyle(
                                                color: customerRoles
                                                    ? Color.fromRGBO(
                                                        255, 255, 255, 1)
                                                    : Colors.white54,
                                                fontFamily: 'beIN',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IgnorePointer(
                                ignoring: !customerRoles,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onPanDown: _handleUserInteraction,
                                  onScaleStart: _handleUserInteraction,
                                  onTap: () async {
                                    _handleUserInteraction();
                                    Navigator.push(
                                        context,
                                        SlideLeftRoute(
                                            page: FilterScreenPage()));
                                  },
                                  child: Container(
                                    height: size.height * 0.2,
                                    width: size.width * 0.42,
                                    child: Card(
                                      elevation: 20,
                                      color: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 70,
                                            child: Image.asset(
                                              'assets/images/query.png',
                                              color: customerRoles
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Colors.white54,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, size.width * 0.04, 0),
                                            // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Text(
                                              'استعلام مشتريات وكيل',
                                              style: TextStyle(
                                                  color: customerRoles
                                                      ? Color.fromRGBO(
                                                          255, 255, 255, 1)
                                                      : Colors.white54,
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
                                behavior: HitTestBehavior.translucent,
                                onPanDown: _handleUserInteraction,
                                onScaleStart: _handleUserInteraction,
                                onTap: () async {
                                  _handleUserInteraction();
                                  Navigator.push(context,
                                      SlideLeftRoute(page: FeedPrices()));
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
                                behavior: HitTestBehavior.translucent,
                                onPanDown: _handleUserInteraction,
                                onScaleStart: _handleUserInteraction,
                                onTap: () async {
                                  _handleUserInteraction();
                                  // var result1 =
                                  //     await Connectivity().checkConnectivity();
                                  // if (result1 == ConnectivityResult.none) {
                                  //   alertDialog(
                                  //       DialogType.ERROR,
                                  //       context,
                                  //       'خطاء في الاتصال',
                                  //       'لا يوجد اتصال بالسرفر',
                                  //       Icons.cancel,
                                  //       Colors.red);
                                  // }

                                  // else {
                                  var ss = await scanQR();

                                  Navigator.push(
                                      context,
                                      SlideLeftRoute(
                                          page: QrCode(
                                        qr: ss,
                                      )));
                                  //  }
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
                              IgnorePointer(
                                ignoring: !customerRoles,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onPanDown: _handleUserInteraction,
                                  onScaleStart: _handleUserInteraction,
                                  onTap: () async {
                                    _handleUserInteraction();
                                    Navigator.push(context,
                                        SlideLeftRoute(page: AddVanScreen()));
                                  },
                                  child: Container(
                                    height: size.height * 0.2,
                                    width: size.width * 0.42,
                                    child: Card(
                                      elevation: 20,
                                      color: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 70,
                                            child: Image.asset(
                                              'assets/images/truck.png',
                                              color: customerRoles
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Colors.white54,
                                            ),
                                          ),
                                          Text(
                                            'اضافة عربية نقل',
                                            style: TextStyle(
                                                color: customerRoles
                                                    ? Color.fromRGBO(
                                                        255, 255, 255, 1)
                                                    : Colors.white54,
                                                fontFamily: 'beIN',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onPanDown: _handleUserInteraction,
                                onScaleStart: _handleUserInteraction,
                                onTap: () async {
                                  _handleUserInteraction();
                                  // Navigator.push(
                                  //   context,
                                  //   MyCustomRoute(
                                  //       builder: (context) =>
                                  //           GiftDashBoardScreen()),
                                  // );
                                  Navigator.push(
                                      context,
                                      SlideLeftRoute(
                                          page: GiftDashBoardScreen()));
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
                                            'الجوائز المقدمة',
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
