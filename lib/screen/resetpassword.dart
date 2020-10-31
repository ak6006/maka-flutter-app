import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maka/screen/login.dart';

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
//   runApp(MaterialApp(home: _name == null ? ResetPassWordScreen() : MyHomePage()));
// }

class ResetPassWordScreen extends StatefulWidget {
  @override
  _ResetPassWordScreenState createState() => _ResetPassWordScreenState();
}

class _ResetPassWordScreenState extends State<ResetPassWordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseHelper databaseHelper = new DatabaseHelper();
  static String _code = '';
  static String _mobile = '';
  static String _password = '';
  bool isValid;
  bool showSpinner = false;

  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _codeController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  // SharedPreferences ResetPassWordScreendata;
  // bool newuser;

  @override
  void setState(fn) {
    super.setState(fn);
    // _passwordController.text = '';
  }

  void initState() {
    // super.initState();
    //_name = '';

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

                    new Padding(
                      padding: new EdgeInsets.only(top: size.height * 0.03),
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
                            image: AssetImage('assets/images/log.png'),
                          ),
                        ),
                        PrimaryNumberField(
                          label: 'كود التفعيل',
                          onChanged: (value) {
                            _code = value.trim();
                            print("First text field: $value");
                            //isValid = EmailValidator.validate(_email);
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'الرجاء ادخال رمز التفعيل';
                            } else if (value.length < 4) {
                              return 'رمز التفعيل اربعة ارقام';
                            } else {
                              return null;
                            }
                          },
                          controller: _codeController,
                        ),
                      ],
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
                            image: AssetImage('assets/images/lock.png'),
                          ),
                        ),
                        PasswordTextField(
                          label: 'كلمة السر الجديده',
                          onChanged: (value) {
                            _password = value.trim();
                          },
                          validatorFun: (String value) {
                            if (value.isEmpty) {
                              return 'الرجاء التاكد من اسم المستخدم او كلمة السر';
                            } else if (value.length < 6) {
                              return 'الرجاء التاكد من اسم المستخدم او كلمة السر';
                            } else {
                              return null;
                            }
                          },
                          controller: _passwordController,
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
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
                                    context, SlideRightRoute(page: LogIn()));
                              },
                              color: Color.fromRGBO(254, 88, 0, 1),
                              child: new Text(
                                ' تسجيل دخول',
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
                                  });
                                }
                                databaseHelper
                                    .resetpassword(
                                        _phoneController.text,
                                        _codeController.text,
                                        _passwordController.text)
                                    .whenComplete(
                                  () async {
                                    // _name = _usernameController.text;
                                    _mobile = _phoneController.text;
                                    if (databaseHelper.status == 'conEr') {
                                      _alertDialog('لا يوجد اتصال بالسيرفر');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else if (databaseHelper.status ==
                                        'expierd') {
                                      _alertDialog(
                                          'رمز التفعيل انتهت مده الصلاحية');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else if (databaseHelper.status ==
                                        'Phone') {
                                      _alertDialog('رقم الهاتف غير صحيح');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else if (databaseHelper.status ==
                                        'Code') {
                                      _alertDialog('كود التفعيل غير صحيح');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else if (databaseHelper.status ==
                                        'Done') {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      // alertDialog(
                                      //     DialogType.SUCCES,
                                      //     context,
                                      //     '',
                                      //     'تم تغيير كلمة السر بنجاح',
                                      //     Icons.add,
                                      //     Colors.green);
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.SUCCES,
                                          animType: AnimType.RIGHSLIDE,
                                          headerAnimationLoop: false,
                                          title: 'تمت بنجاح',
                                          desc: 'تم تغيير كلمة السر بنجاح',
                                          btnOkOnPress: () {
                                            Navigator.push(context,
                                                SlideRightRoute(page: LogIn()));
                                          },
                                          btnOkIcon: Icons.add,
                                          btnOkColor: Colors.green)
                                        ..show();
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
                                  'استعادة كلمة السر',

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

  // void check_if_already_ResetPassWordScreen() async {
  //   ResetPassWordScreendata = await SharedPreferences.getInstance();
  //   newuser = (ResetPassWordScreendata.getBool('ResetPassWordScreen') ?? true);
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
