import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maka/models/vanmodel.dart';

import 'package:maka/utils/constant.dart';
import 'package:maka/utils/primary_number_field.dart';
import 'package:maka/utils/primary_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'dashboard.dart';

class AddVanScreen extends StatefulWidget {
  @override
  _AddVanScreenState createState() => _AddVanScreenState();
}

class _AddVanScreenState extends State<AddVanScreen> {
  // String vannumber;
  // String vandriver;
  // String vanmodel;
  // String vanphone;
  final GlobalKey<FormState> _valkey = GlobalKey<FormState>();
  bool showSpinner = false;
  VanModel vanModel = new VanModel();
  // DropDownItem selectedweghtItems = new DropDownItem();
  TextEditingController _carNumber = TextEditingController();
  TextEditingController _carModel = TextEditingController();
  TextEditingController _carDriver = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  @override
  void initState() {}

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 19),
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 140.0,
                        child: Center(
                          child: Image(
                            height: 250,
                            image: AssetImage('assets/images/lg2.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    // padding: const EdgeInsets.only(left: 30),
                    width: 190,
                    alignment: Alignment.center,
                    color: Color.fromRGBO(254, 88, 0, 1),
                    child: new Text(
                      'اضافة عربية نقل',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              //  buildExpanded(widget.orderquantitysumquery.length),

              Form(
                key: _valkey,
                child: Expanded(
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: PrimaryTextField(
                            label: 'رقم العربية',
                            controller: _carNumber,
                            onChanged: (value) {
                              //vannumber = value;
                              vanModel.number = value;
                            },
                            validate: (String value) {
                              print(value);

                              if (value.isEmpty) {
                                return 'الرجاء ادخال رقم العربية';
                              } else {}
                            },
                            // controller: _usernameController,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //============================================
                        SingleChildScrollView(
                          child: PrimaryTextField(
                            controller: _carModel,
                            label: 'موديل العربية',
                            onChanged: (value) {
                              // vanmodel = value;
                              vanModel.model = value;
                            },
                            validate: (String value) {
                              print(value);

                              if (value.isEmpty) {
                                return 'الرجاء ادخال موديل العربية';
                              } else {}
                            },
                            // controller: _usernameController,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //===============================
                        SingleChildScrollView(
                          child: PrimaryTextField(
                            label: 'سائق العربية',
                            controller: _carDriver,
                            onChanged: (value) {
                              // vandriver = value;
                              vanModel.drivername = value;
                            },
                            validate: (String value) {
                              print(value);

                              if (value.isEmpty) {
                                return 'الرجاء ادخال اسم السائق';
                              } else {}
                            },
                            // controller: _usernameController,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //===============================
                        SingleChildScrollView(
                          child: PrimaryNumberField(
                            label: 'رقم التليفون',
                            controller: _phoneNumber,
                            onChanged: (value) {
                              //  vanphone = value;
                              vanModel.phone = value;
                              //vanModel.toJson()
                            },
                            validate: (String value) {
                              print(value);

                              if (value.isEmpty) {
                                return 'الرجاء ادخال رقم التليفون';
                              } else {}
                            },
                            // controller: _usernameController,
                          ),
                        ),
                        //===============================
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   width: 20,
                            // ),
                            Container(
                              decoration: BoxDecoration(
                                // color: Color.fromRGBO(254, 88, 0, 1),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              height: 40,
                              width: 120,
                              child: new FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Color.fromRGBO(254, 88, 0, 1),
                                child: new Text(
                                  'الغاء',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'beIN',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // color: Color.fromRGBO(254, 88, 0, 1),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              height: 40,
                              width: 120,
                              child: new FlatButton(
                                onPressed: () async {
                                  var result1 =
                                      await Connectivity().checkConnectivity();
                                  if (result1 == ConnectivityResult.none) {
                                    alertDialog(
                                        DialogType.ERROR,
                                        context,
                                        'خطأ في الاتصال',
                                        'لا يوجد اتصال بالسرفر',
                                        Icons.cancel,
                                        Colors.red);
                                  }
                                  // else if (result1 == ConnectivityResult.mobile) {
                                  //   alertDialog(DialogType.ERROR, context, 'خطاء في الاتصال',
                                  //       'انت متصل علي شبكة الموبايل', Icons.cancel, Colors.red);
                                  // }
                                  // else if (result == ConnectivityResult.wifi) {
                                  //   _showDialog(
                                  //       'Internet access', "You're connected over wifi");
                                  // }

                                  else {
                                    if (_valkey.currentState.validate()) {
                                      //  print(jsonEncode(vanModel.toJson()));
                                      setState(() {
                                        showSpinner = true;
                                      });

                                      final res = await databaseHelper
                                          .addvanData(vanModel);

                                      print(res);
                                      if (res == '"تمت الاضافه بنجاح"') {
                                        //++++++++++++++++++++++++++++++++++++++
                                        //  await inislizedata();
                                        //++++++++++++++++++++++++++++++++++++++++++
                                        blocData.fetchdata();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DashBoardPage()));
                                        alertDialog(
                                            DialogType.SUCCES,
                                            context,
                                            'تمت العملية بنجاح',
                                            '',
                                            Icons.add,
                                            Colors.green);
                                      } else {
                                        alertDialog(
                                            DialogType.ERROR,
                                            context,
                                            '$res',
                                            '',
                                            Icons.delete_forever,
                                            Colors.red);
                                      }
                                      setState(() {
                                        showSpinner = false;
                                      });

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           AddOrderScreen()), //FilterScreenPage()),
                                      // );
                                    }
                                  }
                                },
                                color: Color.fromRGBO(254, 88, 0, 1),
                                child: new Text(
                                  'اضافة',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'beIN',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
