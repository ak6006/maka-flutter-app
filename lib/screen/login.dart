import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/password_text_field.dart';
import 'package:maka/utils/primary_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LogIn extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

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
  @override
  void initState() {
    _name = '';
    _password = '';
    showSpinner = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      // appBar: AppBar(
      //   title: Text(widget.title),
      //00000000000
      //111111111111111
      // ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                Container(
                  // color: Color.fromRGBO(0, 51, 94, 1),
                  // decoration: new BoxDecoration(
                  //   borderRadius: new BorderRadius.circular(16.0),
                  //   color: Colors.green,
                  // ),
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
                PrimaryTextField(
                  label: 'اسم المستخدم',
                  onChanged: (value) {
                    _name = value.trim();
                    //isValid = EmailValidator.validate(_email);
                  },
                  // validate: (String value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter your email';
                  //   } else if (isValid == false) {
                  //     return 'Please enter a valid email';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                ),
                SizedBox(
                  height: 12.0,
                ),
                PasswordTextField(
                  onChanged: (value) {
                    _password = value.trim();
                  },
                  validatorFun: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your Password';
                    } else if (value.length < 6) {
                      return 'Must be more than 6 charater';
                    } else {
                      return null;
                    }
                  },
                  // validatorFun: (String value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter your Password';
                  //   } else if (value.length < 8) {
                  //     return 'Must be more than 8 charater';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 40.0),
                ),
                Container(
                  height: 40,
                  width: 160,
                  child: new FlatButton(
                    onPressed: () {
                      setState(() {
                        showSpinner = true;
                      });
                      databaseHelper
                          .loginData(_name, _password)
                          .whenComplete(() {
                        // print('kkkkkkkk${databaseHelper.status}');
                        // return;
                        if (databaseHelper.status) {
                          // _showDialog();
                          //  msgStatus = 'Check email or password';
                          _showDialog(databaseHelper.stateMsg);
                          setState(() {
                            showSpinner = false;
                          });
                        } else {
                          // _showDialog();
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        }
                        //-------
                      });
                    },
                    color: Color.fromRGBO(0, 157, 68, 1),
                    child: new Text(
                      'دخول',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                      ),
                    ),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 40.0),
                ),
                Container(
                  height: 40,
                  width: 160,
                  child: new FlatButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    color: Color.fromRGBO(179, 0, 34, 1),
                    child: new Text(
                      ' تسجيل حساب جديد',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                      ),
                    ),
                  ),
                ),
              ],
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
            title: new Text('خطاء'),
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
