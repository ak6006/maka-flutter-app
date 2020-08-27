import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/password_text_field.dart';
import 'package:maka/utils/primary_text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static String _name;
  static String _mobile;
  static String _password;
  bool isValid;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),

      //SingleChildScrollView
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(
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
                  // isValid = EmailValidator.validate(_email);
                },
                // validate: (String value) {
                //   if (value.isEmpty) {
                //     return 'ادخل اسم المستخدم';
                //   } else if (isValid == false) {
                //     return 'غير صحيح';
                //   } else {
                //     return null;
                //   }
                // },
              ),
              SizedBox(
                height: 12.0,
              ),
              PrimaryTextField(
                label: 'موبايل',
                onChanged: (value) {
                  _mobile = value.trim();
                  //   isValid = EmailValidator.validate(_email);
                },
                // validate: (String value) {
                //   if (value.isEmpty) {
                //     return 'ادخل رقم الموبايل';
                //   } else if (isValid == false) {
                //     return 'ادخل رقم موبايل صحيح';
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
                // validatorFun: (String value) {
                //   if (value.isEmpty) {
                //     return 'ادخل كلمة السر';
                //   } else if (value.length < 8) {
                //     return 'كلمة السر غير صحيحة';
                //   } else {
                //     return null;
                //   }
                // },
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    width: 140,
                    child: new FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      color: Color.fromRGBO(174, 0, 145, 1),
                      child: new Text(
                        ' دخول',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'beIN',
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
                        databaseHelper
                            .registerData(_name, _mobile, _password)
                            .whenComplete(() {
                          if (databaseHelper.codest > 299) {
                            _showDialog();
                            msgStatus = 'Check email or password';
                            print(msgStatus);
                          } else {
                            // _showDialog();
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          }
                          //-------
                        });
                      },
                      color: Color.fromRGBO(0, 157, 68, 1),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('خطاء'),
            content: new Text('تاكد من صحة البيانات'),
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
