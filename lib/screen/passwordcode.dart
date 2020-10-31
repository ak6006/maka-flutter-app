import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maka/screen/login.dart';
import 'package:maka/screen/resetpassword.dart';

import 'package:maka/utils/constant.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/password_text_field.dart';
import 'package:maka/utils/primary_number_field.dart';
import 'package:maka/utils/primary_text_field.dart';
import 'package:maka/utils/slideAnimations.dart';
import 'package:maka/utils/speech.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// Future<void> main() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var _name = prefs.getString('email');
//   print(_name);
//   runApp(MaterialApp(home: _name == null ? PasswordCodeScreen() : MyHomePage()));
// }

class PasswordCodeScreen extends StatefulWidget {
  @override
  _PasswordCodeScreenState createState() => _PasswordCodeScreenState();
}

class _PasswordCodeScreenState extends State<PasswordCodeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseHelper databaseHelper = new DatabaseHelper();

  static String _mobile = '';
  bool isValid;
  bool showSpinner = false;

  final TextEditingController _phoneController = new TextEditingController();

  String tem = "";

  // SharedPreferences PasswordCodeScreendata;
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
                    Container(
                      child: Text(
                          "اولا قم بادخال هاتفك ثم اضغط رمز التفعيل \n ثم انتظر حتى يصلك كود التفعيل \n بعدها انتقل الى الشاشة التالية \n بالضغط على زر تغيير كلمة السر",

                          /// d5oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooolllll
                          style: new TextStyle(
                            color: Colors.orangeAccent,
                            fontFamily: 'beIN',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right),
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
                          label: 'موبايل',
                          onChanged: (value) {
                            _mobile = value.trim();
                            //   isValid = EmailValidator.validate(_email);
                          },
                          validate: (String value) {
                            //00000000000000
                            //00000000000000000000
                            if (value.isEmpty) {
                              return '  يجب ادخال رقم الموبايل ';
                            } else if (value.length < 6) {
                              return 'كلمة السر يجب ان تكون اكبر';
                            } else if ((value.contains(new RegExp(r'[A-Z]')))) {
                              return 'الموبايل يقبل ارقام فقط';
                            } else if ((value.contains(new RegExp(r'[a-z]')))) {
                              return 'الموبايل يقبل ارقام فقط';
                            } else {
                              return null;
                            }
                          },
                          controller: _phoneController,
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
                                        page: ResetPassWordScreen()));
                              },
                              color: Color.fromRGBO(254, 88, 0, 1),
                              child: new Text(
                                ' تغيير كلمة السر',
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
                                        "يرجى الانتظار سوف يصلك كود التفعيل بعد ثواني";
                                  });
                                }
                                passwordCode = "";
                                databaseHelper
                                    .passwordCode(_phoneController.text)
                                    .whenComplete(
                                  () async {
                                    _mobile = _phoneController.text;
                                    if (databaseHelper.status == 'conEr') {
                                      _alertDialog('لا يوجد اتصال بالسيرفر');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else if (databaseHelper.status ==
                                        'error') {
                                      setState(() {
                                        tem = "الهاتف المدخل غير صحيح";
                                        showSpinner = false;
                                      });
                                      // _alertDialog(
                                      //     ' الهاتف غير صحيح');
                                      // setState(() {
                                      //   showSpinner = false;
                                      // });
                                    } else if (databaseHelper.status == 'con') {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      // _alertDialog('تم تغيير كلمة السر بنجاح');
                                      Future.delayed(
                                          const Duration(milliseconds: 3000),
                                          () {
                                        if (passwordCode.length == 4) {
                                          setState(() {
                                            tem =
                                                'رمز التفعيل الخاص بك هو $passwordCode \n يرجى الضغط على رز تغيير كلمة السر للمتابعة';
                                          });
                                          // alertDialog(
                                          //     DialogType.SUCCES,
                                          //     context,
                                          //     '',
                                          //     'رمز التفعيل الخاص بك هو $passwordCode',
                                          //     Icons.add,
                                          //     Colors.green);
                                        } else {
                                          setState(() {
                                            tem = "الرجاء المحاولة لاحقا";
                                            showSpinner = false;
                                          });
                                        }
                                      });

                                      // Navigator.pushReplacementNamed(
                                      //     context, '/PasswordCodeScreen');
                                    }
                                    return;

                                    // if (databaseHelper.status) {
                                    //   if (databaseHelper.connection) {
                                    //     alertDialog(
                                    //         DialogType.ERROR,
                                    //         context,
                                    //         'خطأ في الاتصال',
                                    //         'لا يوجد اتصال بالسرفر',
                                    //         Icons.cancel,
                                    //         Colors.red);

                                    //     setState(() {
                                    //       showSpinner = false;
                                    //     });
                                    //   } else {
                                    //     setState(() {
                                    //       showSpinner = false;
                                    //       _passwordController.text = '';
                                    //       _formKey.currentState.validate();
                                    //     });
                                    //   }
                                    // } else {

                                    //   await initSpeechState();
                                    //   await databaseHelper.saveUserData(
                                    //       _usernameController.text,
                                    //       _passwordController.text);
                                    //   if (datastate == false) {
                                    //     blocData.fetchdata();
                                    //   }

                                    //   Navigator.pushReplacementNamed(
                                    //       context, '/dashboard');
                                    // }
                                  },
                                );
                              },
                              color: Color.fromRGBO(254, 88, 0, 1),
                              child: Container(
                                // width: size.width * 0.1,
                                child: new Text(
                                  ' رمز التفعيل',

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

                    //000000000000000000000000
                    // new Padding(
                    //   padding: new EdgeInsets.only(top: size.height * 0.05),
                    // ),
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

  // void check_if_already_PasswordCodeScreen() async {
  //   PasswordCodeScreendata = await SharedPreferences.getInstance();
  //   newuser = (PasswordCodeScreendata.getBool('PasswordCodeScreen') ?? true);
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
