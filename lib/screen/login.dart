import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maka/screen/passwordcode.dart';
import 'package:maka/screen/resetpassword.dart';

import 'package:maka/utils/constant.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/password_text_field.dart';
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
//   runApp(MaterialApp(home: _name == null ? LogIn() : MyHomePage()));
// }

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseHelper databaseHelper = new DatabaseHelper();
  static String _name = '';
  static String _password = '';
  bool isValid;
  bool showSpinner = false;

  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();

  // SharedPreferences logindata;
  // bool newuser;

  @override
  void setState(fn) {
    super.setState(fn);
    // _passwordController.text = '';
  }

  void initState() {
    // super.initState();
    _name = '';
    _password = '';
    showSpinner = false;
    // _usernameController.addListener(() {
    //   _printLatestValueUser();
    // });
    // _printLatestValueUser();
    //_printLatestValuePass();
    //check_if_already_login();
    //_passwordController.addListener(_printLatestValue);
    readLogin();
  }

  readLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final keyUser = 'user';
    final keyPass = 'pass';
    //final keyPass = _passwordController;
    final valueUser = prefs.get(keyUser) ?? '';
    final valuePass = prefs.get(keyPass) ?? '';
    print('read : $valueUser');
    print('read : $valuePass');
    _usernameController.text = valueUser;
    _passwordController.text = valuePass;
  }

  // _printLatestValueUser() {
  //   print("First text field: ${_name}");
  //   // _usernameController.text = '';
  // }

  // _printLatestValuePass() {
  //   print("Second text field: ${_password}");
  //   // _passwordController.text = '';
  // }

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
                            image: AssetImage('assets/images/log.png'),
                          ),
                        ),
                        PrimaryTextField(
                          label: 'اسم المستخدم',
                          onChanged: (value) {
                            _name = value.trim();
                            print("First text field: $value");
                            //isValid = EmailValidator.validate(_email);
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'الرجاء ادخال اسم المستخدم';
                            } //else if (isValid == false) {
                            //return 'Please enter a valid email';
                            //}
                            else {
                              return null;
                            }
                          },
                          controller: _usernameController,
                        ),
                      ],
                    ),
                    // SizedBox(height: 30,),

                    SizedBox(
                      height: 30.0,
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
                          label: 'كلمة السر',
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

                    new Padding(
                      padding: new EdgeInsets.only(top: size.height * 0.01),
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
                                Navigator.pushReplacementNamed(
                                    context, '/register');
                              },
                              color: Color.fromRGBO(254, 88, 0, 1),
                              child: new Text(
                                ' تسجيل حساب جديد',
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
                                    .loginData(_usernameController.text,
                                        _passwordController.text)
                                    .whenComplete(
                                  () async {
                                    _name = _usernameController.text;
                                    _password = _passwordController.text;
                                    if (databaseHelper.status == 'conEr') {
                                      _alertDialog('لا يوجد اتصال بالسيرفر');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else if (databaseHelper.status ==
                                        'error') {
                                      _alertDialog(
                                          'اسم المستخدم او كلمة السر خطأ');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else if (databaseHelper.status == 'con') {
                                      setState(() {
                                        showSpinner = false;
                                      });

                                      await initSpeechState();
                                      await databaseHelper.saveUserData(
                                          _usernameController.text,
                                          _passwordController.text);
                                      if (datastate == false) {
                                        blocData.fetchdata();
                                      }

                                      Navigator.pushReplacementNamed(
                                          context, '/dashboard');
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
                                  'دخول',

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
                    new Padding(
                      padding: new EdgeInsets.only(top: size.height * 0.05),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            SlideRightRoute(page: PasswordCodeScreen()));
                      },
                      child: Container(
                        child: Text(
                          'هل نسيت كلمة السر ؟ ',

                          /// d5oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooolllll
                          style: new TextStyle(
                            color: Colors.grey,
                            fontFamily: 'beIN',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
        title: 'خطأ في الاتصال',
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

  // void check_if_already_login() async {
  //   logindata = await SharedPreferences.getInstance();
  //   newuser = (logindata.getBool('login') ?? true);
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
