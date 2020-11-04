import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maka/utils/captcha_text_field.dart';
import 'package:maka/utils/confirm_pass_text_field.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/password_text_field.dart';
import 'package:maka/utils/primary_number_field.dart';
import 'package:maka/utils/primary_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String tem = "";
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
                                      return 'ادخل رقم تليفون صحيح';
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
                                  label: 'كلمة السر',
                                  onChanged: (value) {
                                    _password = value.trim();
                                  },
                                  validatorFun: (String value) {
                                    if (value.isEmpty) {
                                      return '  كلمة السر لا يمكن ان تكون فارغة ';
                                    } else if (value.length < 6) {
                                      return 'كلمة السر يجب ان لا تقل عن 6 احرف';
                                    }
                                    // else if (!(value
                                    //     .contains(new RegExp(r'[A-Z]')))) {
                                    //   return 'كلمة السر يجب ان تحتوي على حرف كبير';
                                    // }
                                    else {
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
                                  child: CaptchaTextField(
                                    label: 'اكتب رمز التحقق علي اليمين',
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Padding(
                                  padding: new EdgeInsets.only(right: 10.0),
                                ),
                                Container(
                                  height: 45,
                                  width: 140,
                                  child: new FlatButton(
                                    // onPressed: () async {
                                    //   var result;
                                    //   SystemChannels.textInput
                                    //       .invokeMethod('TextInput.hide');

                                    //   if (_formKey.currentState.validate()) {
                                    //     setState(() {
                                    //       showSpinner = true;
                                    //     });
                                    //   } else {
                                    //     return;
                                    //   }

                                    //   setState(() {
                                    //     showSpinner = true;
                                    //   });
                                    //   result = await databaseHelper
                                    //       .registerData(
                                    //     _name,
                                    //     _mobile,
                                    //     _password, /*_confirmPass*/
                                    //   )
                                    //       .whenComplete(() {
                                    //     if (databaseHelper.status) {
                                    //       //databaseHelper.codest > 299
                                    //       if (databaseHelper.connection) {
                                    //         print('aassddff$result');
                                    //         _alertDialog(
                                    //             'aaaلا يوجد اتصال بالسيرفر');
                                    //         setState(() {
                                    //           showSpinner = false;
                                    //         });
                                    //       } else {
                                    //         setState(() {
                                    //           showSpinner = false;
                                    //         });
                                    //       }

                                    //       // setState(() {
                                    //       //   showSpinner = false;
                                    //       // });
                                    //       //_showDialog('تاكد من صحة البيانات');
                                    //       msgStatus = 'Check email or password';
                                    //       print(msgStatus);
                                    //     } else {
                                    //       // _showDialog();
                                    //       Navigator.pushReplacementNamed(
                                    //           context, '/login');
                                    //     }
                                    //     //-------
                                    //   });
                                    //   if (result.contains('taken')) {
                                    //     _alertDialog('هذا الاسم موجود من قبل');
                                    //     setState(() {
                                    //       showSpinner = false;
                                    //     });
                                    //     return;
                                    //   }
                                    //   print('mmssdf$result');
                                    // },
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
                                        if (databaseHelper.status == 'conEr') {
                                          _alertDialog(
                                              'لا يوجد اتصال بالسيرفر');
                                          setState(() {
                                            showSpinner = false;
                                          });
                                        } else if (databaseHelper.status ==
                                            'taken') {
                                          _alertDialog(
                                              'اسم المستخدم موجود من قبل');
                                          setState(() {
                                            showSpinner = false;
                                          });
                                        } else if (databaseHelper.status ==
                                            'Phone') {
                                          _alertDialog(
                                              'رقم الهاتف مسجل من قبل');
                                          setState(() {
                                            showSpinner = false;
                                          });
                                        } else if (databaseHelper.status ==
                                            'con') {
                                          setState(() {
                                            showSpinner = false;
                                          });
                                          setState(() {
                                            tem = 'تم التسجيل بنجاح';
                                          });
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 3000), () {
                                            // alertDialog(
                                            //     DialogType.SUCCES,
                                            //     context,
                                            //     '',
                                            //     'رمز التفعيل الخاص بك هو $passwordCode',
                                            //     Icons.add,
                                            //     Colors.green);

                                            // setState(() {
                                            //   tem = "الرجاء المحاولة لاحقا";
                                            //   showSpinner = false;
                                            // });
                                            Navigator.pushReplacementNamed(
                                                context, '/login');
                                          });

                                          // alertDialog(
                                          //     DialogType.SUCCES,
                                          //     context,
                                          //     'تم التسجيل بنجاح',
                                          //     '',
                                          //     Icons.add,
                                          //     Colors.green);
                                        }
                                        return;
                                      });
                                    },
                                    color: Color.fromRGBO(254, 88, 0, 1),
                                    child: new Text(
                                      'تسجيل',
                                      style: new TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'beIN',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(top: 20.0),
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
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Container(
                                        height: 40,
                                        width: 120,
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
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(left: 40.0),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Color.fromRGBO(254, 88, 0, 1),
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      height: 40,
                                      width: 120,
                                      child: new FlatButton(
                                        onPressed: () {
                                          // Navigator.pop(context);
                                          Navigator.pushReplacementNamed(
                                              context, '/MyHomePage');
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
                                  ],
                                ),

                                ///dddd
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
