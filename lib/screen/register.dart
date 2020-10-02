import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maka/utils/confirm_pass_text_field.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/password_text_field.dart';
import 'package:maka/utils/primary_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static String _name;
  static String _mobile;
  static String _password;
  //static String _confirmPass;
  static String _verCode;
  bool isValid;
  Text text;
  bool showSpinner = false;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  static const _chars = //'0123456789';
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void initState() {
    text = Text(getRandomString(5));
    _name = '';
    _mobile = '';
    _password = '';
    //_confirmPass = '';
    showSpinner = false;
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),

      //SingleChildScrollView
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
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Form(
                key: _formKey,
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
                            height: 250.0,
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
                    Expanded(
                      child: Container(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
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
                                    height: 20,
                                    image: AssetImage('assets/images/log.png'),
                                  ),
                                ),
                                PrimaryTextField(
                                  label: 'اسم المستخدم',
                                  onChanged: (value) {
                                    _name = value.trim();
                                    // isValid = EmailValidator.validate(_email);
                                  },
                                  validate: (String value) {
                                    //00000000000000
                                    //00000000000000000000
                                    if (value.isEmpty) {
                                      return '  يجب ادخال اسم المستخدم ';
                                    }
                                  },
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
                                    height: 20,
                                    image:
                                        AssetImage('assets/images/mobile.png'),
                                  ),
                                ),
                                PrimaryTextField(
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
                                    } else if ((value
                                        .contains(new RegExp(r'[A-Z]')))) {
                                      return 'الموبايل يقبل ارقام فقط';
                                    } else if ((value
                                        .contains(new RegExp(r'[a-z]')))) {
                                      return 'الموبايل يقبل ارقام فقط';
                                    } else {
                                      return null;
                                    }
                                  },
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
                                    height: 20,
                                    image: AssetImage('assets/images/lock.png'),
                                  ),
                                ),
                                PasswordTextField(
                                  label: '',
                                  onChanged: (value) {
                                    _password = value.trim();
                                  },
                                  validatorFun: (String value) {
                                    if (value.isEmpty) {
                                      return '  كلمة السر لا يمكن ان تكون فارغة ';
                                    } else if (value.length < 6) {
                                      return 'الرجاء التأكد من اسم المستخدم او كلمة السر';
                                    } else if (!(value
                                        .contains(new RegExp(r'[A-Z]')))) {
                                      return 'كلمة السر يجب ان تحتوي على حرف كبير';
                                    } else {
                                      return null;
                                    }
                                  },
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
                                    height: 20,
                                    image: AssetImage('assets/images/lock.png'),
                                  ),
                                ),
                                ConfirmPassTextField(
                                  label: '',

                                  /// Confirm Password
                                  onChanged: (value) {
                                    //   _confirmPass = value.trim();
                                  },
                                  validatorFun: (String value) {
                                    if (value != _password) {
                                      return 'الرجاء التأكد من كتابة كلمة السر الصحيحة';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(top: 20.0),
                            ),
                            Stack(
                              children: <Widget>[
                                Container(
                                  // height: size.height * 0.05,
                                  // width: size.width * 0.08,
                                  margin: EdgeInsets.only(
                                    left: size.width - 70,
                                    top: 15,
                                    right: 0,
                                    bottom: 0,
                                  ),
                                  child: new IconButton(
                                    onPressed: () {
                                      setState(() {
                                        text = Text(getRandomString(5));
                                      });
                                    },
                                    color: Color.fromRGBO(0, 157, 68, 1),
                                    icon: Container(
                                      //  margin: EdgeInsets.only(left: 30),
                                      //    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                      child: Image.asset(
                                        'assets/images/refresh.png',
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: size.width - 150,
                                    top: 20,
                                    right: 0,
                                    bottom: 0,
                                  ),
                                  child: Text(
                                    '${text.data}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Playball',
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 0,
                                    top: 10,
                                    right: size.width - 220,
                                    bottom: 0,
                                  ),
                                  child: PrimaryTextField(
                                    label:
                                        'اكتب رمز التحقق الموجود على يمين الحقل',
                                    onChanged: (value) {
                                      _verCode = value.trim();
                                      //   isValid = EmailValidator.validate(_email);
                                    },
                                    validate: (String value) {
                                      //00000000000000
                                      //00000000000000000000
                                      if (value.isEmpty) {
                                        return '  يرجى ادخال رمز التحقق ';
                                      } else if (_verCode.toLowerCase() !=
                                          text.data.toLowerCase()) {
                                        print(_verCode);
                                        print(text.data);
                                        return 'رمز التحقق غير صحيح';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(top: 30.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 140,
                                  child: new FlatButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    },
                                    color: Color.fromRGBO(254, 88, 0, 1),
                                    child: Container(
                                      width: size.width * 0.6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.09),
                                        child: new Text(
                                          'دخول',
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'beIN',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(right: 10.0),
                                ),
                                Container(
                                  height: 35,
                                  width: 140,
                                  child: new FlatButton(
                                    onPressed: () {
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');

                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                      } else {
                                        return;
                                      }

                                      setState(() {
                                        showSpinner = true;
                                      });
                                      databaseHelper
                                          .registerData(
                                        _name,
                                        _mobile,
                                        _password, /*_confirmPass*/
                                      )
                                          .whenComplete(() {
                                        if (databaseHelper.status) {
                                          //databaseHelper.codest > 299
                                          if (databaseHelper.connection) {
                                            _alertDialog(
                                                'لا يوجد اتصال بالسيرفر');
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          } else {
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          }

                                          // setState(() {
                                          //   showSpinner = false;
                                          // });
                                          //_showDialog('تاكد من صحة البيانات');
                                          msgStatus = 'Check email or password';
                                          print(msgStatus);
                                        } else {
                                          // _showDialog();
                                          Navigator.pushReplacementNamed(
                                              context, '/login');
                                        }
                                        //-------
                                      });
                                    },
                                    color: Color.fromRGBO(254, 88, 0, 1),
                                    child: new Text(
                                      'تسجيل',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'beIN',
                                      ),
                                    ),
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 20.0),
                                ),
                              ],
                            ),
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
      ),
    );
  }

  _alertDialog(String msg) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'خطاء في الاتصال',
        desc: 'لا يوجد اتصال بالسيرفر حاول لاحقا',
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
            content: new Text(msg),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'Close',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
