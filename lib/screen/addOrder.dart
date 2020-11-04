import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:maka/bloca/apiresponse.dart';
import 'package:maka/details/products.dart';
import 'package:maka/details/rightImageProductImageWidget.dart';
import 'package:maka/models/datatable.dart';
import 'package:maka/models/orderQuntitySum.dart';
import 'package:maka/utils/slideAnimations.dart';
import 'package:maka/screen/dashboard.dart';
import 'package:maka/utils/animation.dart';
//import 'package:maka/models/productlist.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/custom_paginated_data_table.dart';
import 'package:maka/utils/data_picker_style.dart';
//import 'package:maka/utils/data_picker_style.dart';
import 'package:maka/utils/databasehelper.dart';
//import 'package:maka/utils/primary_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

//import 'orderQuantityScreen.dart';

class AddOrderScreen extends StatefulWidget {
  bool autoplay = true;
  // List<ProductList> plist;
  //AddOrderScreen({this.plist});
  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  // DateTime timeBeginSelected;
  //DateTime timeEndSelected;
  // DataPicker begin;
  //DataPicker end;
  Timer _timer;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<OrderQuantitySumQuery> orderquantitysumquery;
  DateTime timeEndSelected;
  DataPicker orderdate;
  String title = 'DropDownButton';
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  String prodval;
  // int _prodId;
  // int _storId;
  // int _measureId;
  // int _weghtId;
  String productval = '';
  bool showSpinner = false;
  @override
  void initState() {
    initializeDateFormatting('ar');
    Intl.defaultLocale = 'ar';
    orderdate = new DataPicker(
      dateTime: DateTime.now().add(Duration(days: 1)),
      lable: 'تاريخ الطلبية',
    );

    for (var h in productItems) {
      print(h.price);
    }
    //List fixedList = widget.plist.asMap();
    // productItems.clear();
    // measureItems.clear();
    // weghtItems.clear();
    // storeItems.clear();
    // for (var h in dropDownList.prodNames) {
    //   if (h.productName != 'كل المنتجات') {
    //     productItems.add(DropDownItem(
    //         id: h.productId == 0 ? 0 : h.productId, name: h.productName));
    //   }
    // }
    // for (var h in dropDownList.storeNames) {
    //   storeItems.add(DropDownItem(id: h.storeId, name: h.storeName));
    // }

    // for (var h in dropDownList.measureNames) {
    //   measureItems.add(DropDownItem(id: h.measureId, name: h.measureName));
    // }
    // for (var h in dropDownList.weightNames) {
    //   weghtItems
    //       .add(DropDownItem(id: h.weightId, name: h.weightName.toString()));
    // }

    //refreshList();
    //print('refresheddd');
    _initializeTimer();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(const Duration(minutes: 20), (_) => _logOutUser());
    //print('intializeTimer');
  }

  void _logOutUser() {
    // Navigator.of(ContextClass.CONTEXT)
    //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => true);

  //  Navigator.pushReplacementNamed(context, '/MyHomePage');

    // Log out the user if they're logged in, then cancel the timer.
    // You'll have to make sure to cancel the timer if the user manually logs out
    //   and to call _initializeTimer once the user logs in
    //print('timer execution');
    _timer.cancel();
  }

  // You'll probably want to wrap this function in a debounce
  void _handleUserInteraction([_]) {
    //print('interaction');
    if (!_timer.isActive) {
      // This means the user has been logged out
      return;
    }

    _timer.cancel();
    _initializeTimer();
  }
  // Future<Null> refreshList() async {
  //   refreshkey.currentState?.show(atTop: false);
  //   await Future.delayed(Duration(seconds: 1));
  //   dynamic result = await databaseHelper.addproductData(json);
  //   print(result);
  //   orderquantitysumquery =
  //       OrderQuantitySumQuery.fromJson(result) as List<OrderQuantitySumQuery>;
  //   print(orderquantitysumquery.length);

  //   return null;
  // }

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
                      'اهلا  $agentCustomerName',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: RefreshIndicator(
                    key: refreshkey,
                    // height: 50,
                    color: Colors.deepOrange,
                    backgroundColor: Colors.white,
                    onRefresh: () async {
                      AwesomeDialog(
                        context: context,
                        width: 280,
                        headerAnimationLoop: false,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'تحذير',
                        desc: 'هل تريد نحديث الصفحة',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          //++++++++++++++++++++++++++++++++++++++
                          //  await inislizedata();
                          //++++++++++++++++++++++++++++++++++++++++++
                          blocData.fetchdata();
                          setState(() {});
                          print('refressssssssssssssssssssssssh');
                        },
                        btnOkText: 'نعم',
                        btnCancelText: 'الغاء',
                      )..show();
                      //await refreshList();
                    },
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        snapshotdata.data.status == Status.COMPLETED
                            ? productSlideImage(context)
                            : Container(
                                height: 60,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),

                        snapshotdata.data.status == Status.COMPLETED
                            ? datatableScrollview(context)
                            : Container(
                                height: 60,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                        // orderdate,
                        // datatableScrollview(context),
                        // buildStoreContainer(context),
                        SizedBox(
                          height: 18.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: Color.fromRGBO(254, 88, 0, 1),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              height: 40,
                              width: 120,
                              child: new FlatButton(
                                onPressed: () {
                                  // print('vbn${productItems[2].name}');

                                  // Navigator.push(
                                  //   context,
                                  //   MyCustomRoute(
                                  //       builder: (context) => DashBoardPage()),
                                  // );
                                  Navigator.push(context,
                                      SlideRightRoute(page: DashBoardPage()));
                                },
                                color: Color.fromRGBO(254, 88, 0, 1),
                                child: new Text(
                                  'الغاء الطلب',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'beIN',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 18.0,
                            ),
                            Container(
                              // margin: EdgeInsets.only(
                              //     top: MediaQuery.of(context).size.height * 0.05),
                              decoration: BoxDecoration(
                                // color: Color.fromRGBO(254, 88, 0, 1),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              height: 40,
                              width: 120,
                              child: new FlatButton(
                                onPressed: () async {
                                  _handleUserInteraction();
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
                                    // var json = jsonEncode(
                                    //     orders.map((e) => e.toJson()).toList());
                                    // dropDownList.customerOrders.
                                    setState(() {
                                      showSpinner = true;
                                    });

                                    // print(json);
                                    var res = await databaseHelper
                                        .addproductData(json);
                                    //++++++++++++++++++++++++++++++++++++++
                                    //  await inislizedata();
                                    //++++++++++++++++++++++++++++++++++++++++++
                                    blocData.fetchdata();
                                    print('gbddddd$res');
                                    if (res == '"Done"') {
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
                                          'يوجد مشكله في الاتصال',
                                          '',
                                          Icons.delete_forever,
                                          Colors.red);
                                    }
                                    setState(() {
                                      showSpinner = false;
                                    });

                                    // var result = await databaseHelper.getQantityData(

                                    //     begin.dateTime.toString(),
                                    //     end.dateTime.toString(),
                                    //     productval.toString());

                                    // orderquantitysumquery = orderQuantitySumQueryFromJson(result);

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => OrderQuantityScreen(
                                    //             orderquantitysumquery: orderquantitysumquery,
                                    //           )),
                                    // );

                                    // return;
                                  }
                                },
                                color: Color.fromRGBO(254, 88, 0, 1),
                                child: new Text(
                                  'تاكيد الطلب',
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

  SingleChildScrollView datatableScrollview(BuildContext context) {
    return SingleChildScrollView(
      child: CustomPaginatedDataTable(
        color: Colors.black12,
        rowsPerPage: (3),
        actions: <IconButton>[
          IconButton(
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
        header: Text(
          ': الطلبيات',
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.black,
            fontFamily: 'beIN',
          ),
        ),
        source: TableData(
            // userInHome: widget.userInHome,
            // list_payment: widget.payment_queu,
            // pr: pr,
            // payments: widget.payment_queu,
            // uid: widget.uid,
            context: context),
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              'حذف',
              style: kColumnLabelStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'تعديل',
              style: kColumnLabelStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'تاريخ الطبية',
              style: kColumnLabelStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'الكمية',
              style: kColumnLabelStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'حجم الشكارة',
              style: kColumnLabelStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'الوزن',
              style: kColumnLabelStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'اسم العلف',
              style: kColumnLabelStyle,
            ),
          ),
        ],
      ),
    );
  }

  Container productSlideImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 500.0,
          autoPlay: true, // widget.autoplay,
          aspectRatio: 16 / 9,
          autoPlayInterval: Duration(seconds: 2),
        ),
        items: productItems.map((i) {
          if (i.id == 0) {
            return null;
          }
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width - 130,
                // height: 10,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                //margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    //mm
                    //  color: Colors.amber
                    //--
                    ),
                child: RightImageProductImageWidget(
                  screenHeight: 70.0,
                  product: new Product(
                    backgroundColor: Color(0xFFF5F5F5),
                    imagePath: 'assets/images/${i.id}.png',
                    name: i.name,
                    description: '${i.price} EGP',
                    buttonText: 'اطلبه الان',
                  ),
                  orderproductItems: i,
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     FlatButton.icon(
                //       icon: Expanded(
                //         child: Container(
                //           height: 90,
                //           // margin: EdgeInsets.only(left: 30),
                //           //  margin: EdgeInsets.fromLTRB(0, 0, 10, 30),
                //           child: Image.asset(
                //             'assets/images/${i.id}.png',
                //           ),
                //         ),
                //       ),
                //       label: Text('hhh'),
                //       onPressed: () async {
                //         print(i.name);
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => AddOrderItemsScreen(
                //                     orderproductItems: i,
                //                   )), //FilterScreenPage()),
                //         );
                //       },
                //     ),
                //     Container(
                //       //width: size.width * 0.45,
                //       // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                //       child: Container(
                //         margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                //         child: Text(
                //           i.name,
                //           style: TextStyle(
                //               color: Color.fromRGBO(255, 255, 255, 1),
                //               fontFamily: 'beIN',
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  // Expanded buildSelectedProdDoneExpanded(BuildContext context) {
  //   return Expanded(
  //     child: Container(
  //       child: ListView(
  //         scrollDirection: Axis.vertical,
  //         children: <Widget>[
  //           // buildStoreContainer(context),
  //           // buildProductContainer(context),
  //           //  buildMeasureContainer(context),
  //           //buildWeghtContainer(context),
  //           SizedBox(
  //             height: 18.0,
  //           ),
  //           PrimaryTextField(
  //             label: 'الكمية',
  //             onChanged: (value) {
  //               // _name = value.trim();
  //               print("First text field: $value");
  //               //isValid = EmailValidator.validate(_email);
  //             },
  //             // validate: (String value) {
  //             //   if (value.isEmpty) {
  //             //     return 'الرجاء ادخال اسم المستخدم';
  //             //   } //else if (isValid == false) {
  //             //   //return 'Please enter a valid email';
  //             //   //}
  //             //   else {
  //             //     return null;
  //             //   }
  //             // },
  //             // controller: _usernameController,
  //           ),
  //           SizedBox(
  //             height: 18.0,
  //           ),
  //           Row(
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                   // color: Color.fromRGBO(254, 88, 0, 1),
  //                   borderRadius: BorderRadius.circular(60),
  //                 ),
  //                 height: 40,
  //                 width: 160,
  //                 child: new FlatButton(
  //                   onPressed: () {
  //                     // print('vbn${productItems[2].name}');

  //                     Navigator.pop(context);
  //                   },
  //                   color: Color.fromRGBO(254, 88, 0, 1),
  //                   child: new Text(
  //                     'الغاء الطلب',
  //                     style: new TextStyle(
  //                       color: Colors.white,
  //                       fontFamily: 'beIN',
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 18.0,
  //               ),
  //               Container(
  //                 // margin: EdgeInsets.only(
  //                 //     top: MediaQuery.of(context).size.height * 0.05),
  //                 decoration: BoxDecoration(
  //                   // color: Color.fromRGBO(254, 88, 0, 1),
  //                   borderRadius: BorderRadius.circular(60),
  //                 ),
  //                 height: 40,
  //                 width: 160,
  //                 child: new FlatButton(
  //                   onPressed: () async {
  //                     // var result = await databaseHelper.getQantityData(

  //                     //     begin.dateTime.toString(),
  //                     //     end.dateTime.toString(),
  //                     //     productval.toString());

  //                     // orderquantitysumquery = orderQuantitySumQueryFromJson(result);

  //                     // Navigator.push(
  //                     //   context,
  //                     //   MaterialPageRoute(
  //                     //       builder: (context) => OrderQuantityScreen(
  //                     //             orderquantitysumquery: orderquantitysumquery,
  //                     //           )),
  //                     // );

  //                     // return;
  //                   },
  //                   color: Color.fromRGBO(254, 88, 0, 1),
  //                   child: new Text(
  //                     'تاكيد الطلب',
  //                     style: new TextStyle(
  //                       color: Colors.white,
  //                       fontFamily: 'beIN',
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Container buildProductContainer(BuildContext context) {
  //   return Container(
  //     height: 60,
  //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
  //     child: Center(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.orange[100], width: 2),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(0.0),
  //           child: DropdownButton(
  //             hint: Text(
  //               'اختر المنتج',
  //               style: TextStyle(color: Colors.orange),
  //             ),
  //             dropdownColor: Colors.black87,
  //             elevation: 20,
  //             icon: Icon(Icons.arrow_drop_down),
  //             iconSize: 36,
  //             iconEnabledColor: Colors.deepOrange,
  //             underline: SizedBox(),
  //             isExpanded: true,
  //             value: _prodId,
  //             //style: TextStyle(color: Colors.black),
  //             onChanged: (value) {
  //               print(value);
  //               setState(() {
  //                 _prodId = value;

  //                 // prodval = value;
  //                 //productval = value;
  //                 if (productval == 'كل المنتجات') {
  //                   productval = '';
  //                 }
  //               });
  //             },
  //             items: productItems
  //                 .map(
  //                   (e) => DropdownMenuItem(
  //                     value: e.id.toInt(),
  //                     child: Container(
  //                       margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
  //                       child: Text(
  //                         e.name.toString(),
  //                         textAlign: TextAlign.right,
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontFamily: 'beIN',
  //                           // fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //                 .toList(),
  //             //     product.map((value) {
  //             //   return DropdownMenuItem(
  //             //     value: value,
  //             //     child: Text(
  //             //       value,
  //             //       style: TextStyle(color: Colors.white),
  //             //     ),
  //             //   );
  //             // }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Container buildStoreContainer(BuildContext context) {
  //   return Container(
  //     height: 60,
  //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
  //     child: Center(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.orange[100], width: 2),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(0.0),
  //           child: DropdownButton(
  //             hint: Text(
  //               'اختر عربية النقل',
  //               style: TextStyle(color: Colors.orange),
  //             ),
  //             dropdownColor: Colors.black87,
  //             elevation: 20,
  //             icon: Icon(Icons.arrow_drop_down),
  //             iconSize: 36,
  //             iconEnabledColor: Colors.deepOrange,
  //             underline: SizedBox(),
  //             isExpanded: true,
  //             value: _storId,
  //             //style: TextStyle(color: Colors.black),
  //             onChanged: (value) {
  //               print(value);
  //               setState(() {
  //                 _storId = value;

  //                 // prodval = value;
  //                 //productval = value;
  //                 // if (productval == 'كل المنتجات') {
  //                 //   productval = '';
  //                 // }
  //               });
  //             },
  //             items: vanDriver
  //                 .map(
  //                   (e) => DropdownMenuItem(
  //                     value: e.id.toInt(),
  //                     child: Container(
  //                       margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
  //                       child: Row(
  //                         children: [
  //                           Checkbox(
  //                             hoverColor: Colors.indigo,
  //                             onChanged: (bool value) {
  //                               setState(() {
  //                                 // sel.add()
  //                                 e.state = value;
  //                               });
  //                             },
  //                             value: e.state, // sel[e.id - 3],
  //                           ),
  //                           Text(
  //                             e.name.toString(),
  //                             textAlign: TextAlign.right,
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontFamily: 'beIN',
  //                               //  fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //                 .toList(),
  //             //     product.map((value) {
  //             //   return DropdownMenuItem(
  //             //     value: value,
  //             //     child: Text(
  //             //       value,
  //             //       style: TextStyle(color: Colors.white),
  //             //     ),
  //             //   );
  //             // }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  //----------------------------------------

  // Container buildMeasureContainer(BuildContext context) {
  //   return Container(
  //     height: 60,
  //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
  //     child: Center(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.orange[100], width: 2),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(0.0),
  //           child: DropdownButton(
  //             hint: Text(
  //               'اختر وحدة القياس',
  //               style: TextStyle(color: Colors.orange),
  //             ),
  //             dropdownColor: Colors.black87,
  //             elevation: 20,
  //             icon: Icon(Icons.arrow_drop_down),
  //             iconSize: 36,
  //             iconEnabledColor: Colors.deepOrange,
  //             underline: SizedBox(),
  //             isExpanded: true,
  //             value: _measureId,
  //             //style: TextStyle(color: Colors.black),
  //             onChanged: (value) {
  //               print(value);
  //               setState(() {
  //                 _measureId = value;

  //                 // prodval = value;
  //                 //productval = value;
  //               });
  //             },
  //             items: measureItems
  //                 .map(
  //                   (e) => DropdownMenuItem(
  //                     value: e.id.toInt(),
  //                     child: Container(
  //                       margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
  //                       child: Text(
  //                         e.name.toString(),
  //                         textAlign: TextAlign.right,
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontFamily: 'beIN',
  //                           // fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //                 .toList(),
  //             //     product.map((value) {
  //             //   return DropdownMenuItem(
  //             //     value: value,
  //             //     child: Text(
  //             //       value,
  //             //       style: TextStyle(color: Colors.white),
  //             //     ),
  //             //   );
  //             // }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // //.------------------------------------------

  // Container buildWeghtContainer(BuildContext context) {
  //   return Container(
  //     height: 60,
  //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
  //     child: Center(
  //       child: Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.orange[100], width: 2),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(0.0),
  //           child: DropdownButton(
  //             hint: Container(
  //               child: Text(
  //                 'اختر الوزن',
  //                 // textAlign: TextAlign.center,
  //                 style: TextStyle(color: Colors.orange),
  //               ),
  //             ),
  //             dropdownColor: Colors.black87,
  //             elevation: 20,
  //             icon: Icon(Icons.arrow_drop_down),
  //             iconSize: 36,
  //             iconEnabledColor: Colors.deepOrange,
  //             underline: SizedBox(),
  //             isExpanded: true,
  //             value: _weghtId,
  //             //style: TextStyle(color: Colors.black),
  //             onChanged: (value) {
  //               print(value);
  //               setState(() {
  //                 _weghtId = value;

  //                 // prodval = value;
  //                 //productval = value;
  //               });
  //             },
  //             items: weghtItems
  //                 .map(
  //                   (e) => DropdownMenuItem(
  //                     value: e.id.toInt(),
  //                     child: Container(
  //                       margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
  //                       child: Text(
  //                         e.name.toString(),
  //                         textAlign: TextAlign.right,
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontFamily: 'beIN',
  //                           //    fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //                 .toList(),
  //             //     product.map((value) {
  //             //   return DropdownMenuItem(
  //             //     value: value,
  //             //     child: Text(
  //             //       value,
  //             //       style: TextStyle(color: Colors.white),
  //             //     ),
  //             //   );
  //             // }).toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
