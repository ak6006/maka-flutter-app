import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maka/models/customertransquery.dart';
import 'package:maka/models/transquery.dart';
import 'package:maka/screen/customertransquery.dart';
import 'package:maka/screen/dashboard.dart';
import 'package:maka/screen/transQueryscanner.dart';
import 'package:maka/utils/animation.dart';
import 'package:maka/utils/databasehelper.dart';

class VinPage extends StatefulWidget {
  //عربات النقل
  @override
  _VinPageState createState() => _VinPageState();
}

class _VinPageState extends State<VinPage> {
  List<TransQuery> transquery;
  List<CustomerTransQuery> customertransquery;
  DatabaseHelper databaseHelper = new DatabaseHelper();

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color.fromRGBO(0, 51, 94, 1),

      //SingleChildScrollView
      body: Padding(
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
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                Container(
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
                        height: 40, //size.height * 0.07,
                        image: AssetImage('assets/images/van-orange.png'),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: size.width * 0.3,
                        // height: size.height * 0.07,
                        // width: size.width * 0.4,
                        child: new Text(
                          'عربات النقل',
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
                  padding: new EdgeInsets.only(top: 80.0),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(254, 88, 0, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // color: Color.fromRGBO(254, 88, 0, 1),
                  //height: 40, //size.height * 0.07,
                  // width: 220, //size.width * 0.7,
                  height: size.height * 0.06,
                  width: size.width * 0.7,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          // width: size.width * 0.35,
                          child: FlatButton.icon(
                            label: Container(
                              //margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              width: size.width * 0.45,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    size.width * 0.1, 0, size.width * 0.01, 0),
                                child: Text(
                                  'طلبيات عربية نقل',
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
                              //    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Image.asset('assets/images/in-van.png'),
                            ),
                            // onPressed: () {
                            //   Navigator.pushReplacementNamed(context, '/login');
                            // },
                            onPressed: () async {
                              var brcode = await scanBarcodeNormal();
                              dynamic result =
                                  await databaseHelper.getQueryData(brcode);

                              transquery = transQueryFromJson(result);
                              //  print(transquery.length);
                              // for (TransQuery f in transquery) {
                              //   print(f.date);
                              // }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TransVanPage(transquery: transquery)),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                new Padding(
                  padding: new EdgeInsets.only(top: 10.0),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(254, 88, 0, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // color: Color.fromRGBO(254, 88, 0, 1),
                  // height: 40, //size.height * 0.07,
                  // width: 220, //size.width * 0.7,
                  height: size.height * 0.06,
                  width: size.width * 0.7,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: size.width * 0.35,
                          child: FlatButton.icon(
                            label: Container(
                              width: size.width * 0.45,
                              //margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    size.width * 0.15, 0, size.width * 0.01, 0),
                                child: Text(
                                  'عربيات وكيل',
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
                                //  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child:
                                    Image.asset('assets/images/out-van.png')),
                            // onPressed: () {
                            //   Navigator.pushReplacementNamed(context, '/login');
                            // },
                            onPressed: () async {
                              _checkInternetConnectivity();
                              // var brcode = await scanBarcodeNormal();

                              //for (CustomerTransQuery f in customertransquery) {
                              // print('ddd${f.transVehcileDriverName}');
                              //}
                              // return;
                              var result;
                              if (result.contains('error') ||
                                  result == '' ||
                                  result == null) return;

                              Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => CustomerTransPage(
                                        customertransquery:
                                            customertransquery)),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                new Padding(
                  padding: new EdgeInsets.only(top: 30.0),
                ),
                Container(
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(254, 88, 0, 1),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  // height: 40,
                  // width: 220,
                  height: size.height * 0.06,
                  width: size.width * 0.7,
                  child: new FlatButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                      // Navigator.push(
                      //   context,
                      //   MyCustomRoute(builder: (context) => DashBoardPage()),
                      // );
                    },
                    color: Color.fromRGBO(254, 88, 0, 1),
                    child: Container(
                      child: new Text(
                        'رجوع',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'beIN',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                //000000000000000000
              ],
            ),
          ),
        ),
      ),
    );
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog('لا يوجد انترنت', "انت غير متصل بالشبكة");
    }
    // else if (result == ConnectivityResult.mobile) {
    //   _showDialog('Internet access', "You're connected over mobile data");
    // } else if (result == ConnectivityResult.wifi) {
    //   _showDialog('Internet access', "You're connected over wifi");
    // }
  }

  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
