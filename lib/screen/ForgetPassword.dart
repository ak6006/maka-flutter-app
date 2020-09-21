import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/password_text_field.dart';
import 'package:maka/utils/primary_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseHelper databaseHelper = new DatabaseHelper();
  static String _name = '';
  static String _password = '';
  bool isValid;
  bool showSpinner = false;

  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();

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
                          label: '',
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
                      padding: new EdgeInsets.only(top: size.height * 0.05),
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
                              onPressed: () {
                                /// THIS FLATBUTTON IS FOR LOGINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
                                //print('vxxxxx${_passwordController.text}');
                                //print('544444${_usernameController.text}');
                                databaseHelper.saveUserData(
                                    _usernameController.text,
                                    _passwordController.text);

                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                //  setState(() {
                                // If the form is valid,
                                print('gag${_passwordController.text}');

                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                } else {
                                  // setState(() {
                                  //   _passwordController.value = null;
                                  //   _password = '';
                                  // });

                                  // return;
                                }
                                print('gag${_passwordController.text}');

                                //});
                                databaseHelper
                                    .loginData(_usernameController.text,
                                        _passwordController.text)
                                    .whenComplete(() {
                                  _name = _usernameController.text;
                                  _password = _passwordController.text;
                                  if (_name != '' && _password != '') {
                                    print('Sucessful');
                                    //     logindata.setBool('login', false);
                                    //     logindata.setString('_name', _name);
                                  }
                                  // print('kkkkkkkk${databaseHelper.status}');
                                  // return;
                                  if (databaseHelper.status) {
                                    // _showDialog();
                                    //  msgStatus = 'Check email or password';
                                    if (databaseHelper.connection) {
                                      _showDialog('لا يوجد اتصال بالسيرفر');
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    } else {
                                      setState(() {
                                        showSpinner = false;
                                        _passwordController.text = '';
                                        _formKey.currentState.validate();
                                      });
                                    }

                                    //_showDialog(databaseHelper.stateMsg
                                  } else {
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext ctx) =>
                                    //             MyHomePage()));
                                    // _showDialog();
                                    print('logged in successfully');

                                    Navigator.pushReplacementNamed(
                                        context, '/dashboard');
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             DashBoardPage()));
                                    // }
                                  }
                                }

                                        //-------
                                        //}
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

  void _showDialog(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('خطأ'),
            content: new Text('$msg'),
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
