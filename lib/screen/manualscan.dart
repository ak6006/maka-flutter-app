import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maka/models/querybarcode.dart';
import 'package:maka/screen/barcodescannr.dart';

import 'package:maka/screen/scandashboard.dart';
import 'package:maka/utils/animation.dart';

import 'package:maka/utils/databasehelper.dart';

import 'package:maka/utils/primary_number_field.dart';

import 'package:maka/utils/slideAnimations.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

// Future<void> main() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var _name = prefs.getString('email');
//   print(_name);
//   runApp(MaterialApp(home: _name == null ? ManualScanScreen() : MyHomePage()));
// }

class ManualScanScreen extends StatefulWidget {
  @override
  _ManualScanScreenState createState() => _ManualScanScreenState();
}

class _ManualScanScreenState extends State<ManualScanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseHelper databaseHelper = new DatabaseHelper();

  static String _code = '';
  bool isValid;
  bool showSpinner = false;

  QueryBarCode queryBarCode;

  String _textSelect(String str) {
    str = str.replaceAll('[', '');
    str = str.replaceAll(']', '');

    return str;
  }

  final TextEditingController _codeController = new TextEditingController();

  String tem = "";

  // SharedPreferences ManualScanScreendata;
  // bool newuser;

  @override
  void setState(fn) {
    super.setState(fn);
    // _passwordController.text = '';
  }

  void initState() {
    // super.initState();

    showSpinner = false;
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      // backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      backgroundColor: Colors.black,

      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(top: size.height * 0.04),
                    ),
                    Container(
                      child: Flexible(
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            height: 200.0,
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

                    SizedBox(
                      height: 12.0,
                    ),

                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            left: size.width - 80,
                            top: 10,
                            right: 0,
                            bottom: 0,
                          ),
                          child: Image(
                            height: 30,
                            image: AssetImage('assets/images/arrow.png'),
                          ),
                        ),
                        PrimaryNumberField(
                          label: 'الباركود',
                          onChanged: (value) {
                            _code = value.trim();
                            //   isValid = EmailValidator.validate(_email);
                          },
                          validate: (String value) {
                            //00000000000000
                            //00000000000000000000
                            if (value.isEmpty) {
                              return '  يجب ادخال الباركود ';
                            } else {
                              return null;
                            }
                          },
                          controller: _codeController,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      child: Text(
                        '$tem',

                        /// d5oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooolllll
                        style: new TextStyle(
                          color: Colors.orangeAccent,
                          fontFamily: 'beIN',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // new Padding(
                    //   padding: new EdgeInsets.only(top: size.height * 0.03),
                    // ),

                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            // margin: EdgeInsets.only(left: size.width * 0.05),
                            height: 40,
                            width: 140,
                            child: new FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    SlideRightRoute(
                                        page: ScanDashBoardScreen()));
                              },
                              color: Color.fromRGBO(254, 88, 0, 1),
                              child: new Text(
                                ' رجوع',
                                ////  tasgeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeel gdeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'beIN',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // new Padding(
                          //   padding: new EdgeInsets.only(left: size.width * 0.15),
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            //margin: EdgeInsets.only(left: size.width * 0.09),
                            height: 40,
                            width: 140,
                            child: new FlatButton(
                              onPressed: () async {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');

                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    showSpinner = true;
                                    tem =
                                        "يرجى الانتظار سوف يصلك البيانات بعد ثواني";
                                  });
                                }
                                var result1 =
                                    await Connectivity().checkConnectivity();
                                if (result1 == ConnectivityResult.none) {
                                  setState(() {
                                    showSpinner = false;
                                    tem = "لا يوجد اتصال بالسيرفر";
                                  });
                                  // alertDialog(
                                  //     DialogType.ERROR,
                                  //     context,
                                  //     'خطأ في الاتصال',
                                  //     'لا يوجد اتصال بالسرفر',
                                  //     Icons.cancel,
                                  //     Colors.red);
                                } else {
                                  dynamic result = await databaseHelper
                                      .getData(_codeController.text);
                                  if (result == '') {
                                    setState(() {
                                      showSpinner = false;
                                      tem = "هذه السريال ليس لمكة هاي فيد";
                                    });
                                    // alertDialog(
                                    //     DialogType.ERROR,
                                    //     context,
                                    //     'خطاء في السريال ',
                                    //     'هذه السريال ليس لمكة هاي فيد',
                                    //     Icons.cancel,
                                    //     Colors.red);
                                    return;
                                  }

                                  String output = _textSelect(result);
                                  queryBarCode = queryBarCodeFromJson(output);
                                  print(queryBarCode.customerName);
                                  setState(() {
                                    showSpinner = false;
                                    tem = "";
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
                              color: Color.fromRGBO(254, 88, 0, 1),
                              child: Container(
                                // width: size.width * 0.1,
                                child: new Text(
                                  ' استعلام',

                                  /// d5oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooolllll
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'beIN',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
          ),
        ),
      ),
    );
  }

  _alertDialog(String msg) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'خطاء  ',
        desc: msg, //'يوجد اتصال بالسيرفر حاول لاحقا',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  void _showDialog(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('خطأ'),
            content: new Text('$msg'),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  'موافق',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            backgroundColor: Colors.yellowAccent[300],
          );
        });
  }

  // void check_if_already_ManualScanScreen() async {
  //   ManualScanScreendata = await SharedPreferences.getInstance();
  //   newuser = (ManualScanScreendata.getBool('ManualScanScreen') ?? true);
  //   print(newuser);
  //   if (newuser == false) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => MyHomePage()));
  //   }
  // }

  // void dispose() {
  //   _usernameController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }
}
