// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maka/models/dropdownlist.dart';
//import 'package:maka/models/customertransquery.dart';
//import 'package:maka/models/orderQuntitySum.dart';
import 'package:maka/screen/addOrder.dart';
import 'package:maka/utils/animation.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/data_picker_style.dart';
import 'package:maka/utils/primary_number_field.dart';
// import 'package:maka/utils/primary_text_field.dart';
// import 'package:maka/utils/customdropdown.dart' as custom;

// ignore: must_be_immutable
class AddOrderItemsScreen extends StatefulWidget {
  //List<CustomerTransQuery> customertransquery;
  DropDownItem orderproductItems;
  AddOrderItemsScreen({this.orderproductItems});

  @override
  _AddOrderItemsScreenState createState() => _AddOrderItemsScreenState();
}

class _AddOrderItemsScreenState extends State<AddOrderItemsScreen> {
  final GlobalKey<FormState> _valkey = GlobalKey<FormState>();
  DateTime timeEndSelected;
  DataPicker orderdate;
  // int _weghtId;
  int _vanId = null;
  double quantity = 0;
  TextEditingController _weightController = TextEditingController();
  DropDownItem selectedweghtItems = DropDownItem();
  List<OrderCar> selectedvanDriver = [];

  @override
  void initState() {
    for (var h in vanDriver) {
      h.state = false;
    }
    orderdate = new DataPicker(
      dateTime: DateTime.now().add(Duration(days: 1)),
      lable: 'تاريخ الطلبية',
    );
    selectedvanDriver.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      body: Container(
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
                    'اضافة طلبية جديدة',
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
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        child: Image(
                          image: AssetImage(
                            'assets/images/${widget.orderproductItems.id}.png',
                          ),
                          height: 110,
                        ),
                      ),
                      Container(
                        //width: size.width * 0.45,
                        // margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          alignment: Alignment.center,
                          // margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                          child: Text(
                            widget.orderproductItems.name,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'beIN',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      orderdate,
                      new Padding(
                        padding: new EdgeInsets.only(top: 20.0),
                      ),

                      SingleChildScrollView(
                        child: PrimaryNumberField(
                          label: ' الكمية بالطن',

                          controller: _weightController,
                          onChanged: (value) {
                            quantity = double.parse(value);

                            // _name = value.trim();
                            print("First text field: ${value}");
                            //isValid = EmailValidator.validate(_email);
                          },
                          validate: (String value) {
                            double v;
                            if (value.contains('.')) {
                              v = double.parse(value.toString());
                              int b = value.indexOf('.');
                              int c = int.parse(value.substring(b + 1));
                              if (c != 5) {
                                return 'الوزن بداية من نصف طن و مضاعفتها فقط';
                              }
                            }
                            print(value);

                            if (value.isEmpty) {
                              return 'الرجاء ادخال الكمية';
                            } else {}
                          },
                          //else if (isValid == false) {
                          //   //return 'Please enter a valid email';
                          //   //}
                          //   else {
                          //     return null;
                          //   }
                          // },
                          // controller: _usernameController,
                        ),
                      ),

                      new Padding(
                        padding: new EdgeInsets.only(top: 0.0),
                      ),
                      buildWeghtContainer(context),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      buildVanDriverContainer(context),
                      new Padding(
                        padding: new EdgeInsets.only(top: 40.0),
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
                              onPressed: () {
                                if (_valkey.currentState.validate()) {
                                  //   print(int.parse(weghtItems[weghtItems
                                  //               .indexOf(widget.orderproductItems)]
                                  //           .name)
                                  //       .toString());
                                  //   return;
                                  // var ff=weghtItems.indexOf(widget.orderproductItems);
                                  orders.add(CustomerOrder(
                                      orderId: 0,
                                      orderHasProductId: 0,
                                      orderDate: orderdate.dateTime,
                                      productId: widget.orderproductItems.id,
                                      productName:
                                          widget.orderproductItems.name,
                                      wieghtId: selectedweghtItems.id,
                                      wieghtName:
                                          int.parse(selectedweghtItems.name),
                                      measureId: measureItems[0].id,
                                      measureName: measureItems[0].name,
                                      quantity: quantity,
                                      orderCars: selectedvanDriver));
                                  // String jsonUser = jsonEncode(
                                  //     orders[orders.length - 1].toJson());

                                  Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) =>
                                            AddOrderScreen()), //FilterScreenPage()),
                                  );
                                }
                                //  setState(() {});
                                //  return;
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
    );
  }

  DropdownButtonHideUnderline buildWeghtContainer(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        //DropdownButton

        // style: TextStyle(height: 0.5),
        style: TextStyle(
            height: 0.1,
            color: Colors.white,
            fontFamily: 'beIN',
            fontWeight: FontWeight.bold,
            fontSize: 16),
        // hint: Container(
        //   child: Padding(
        //     padding: const EdgeInsets.all(0.0),
        //     child: Text(
        //       'اختار حجم الشكارة',
        //       // textAlign: TextAlign.center,
        //       style: TextStyle(color: Colors.orange, fontSize: 17),
        //     ),
        //   ),
        // ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            'اختر حجم الشكارة',
            style: TextStyle(color: Colors.white54),
          ),
        ),

        dropdownColor: Colors.black87,

        elevation: 20,
        isDense: true,

        // decoration: InputDecoration(
        //   //  labelText: label,
        //   // hintText: 'label',
        //   hintStyle: TextStyle(color: Colors.white54),
        //   //labelStyle: TextStyle(fontFamily: "Subtitle"),
        //   fillColor: Colors.white,
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //     borderSide: BorderSide(
        //       color: Colors.amber,
        //     ),
        //   ),
        //   enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //     borderSide: BorderSide(
        //       color: Colors.orange[800],
        //       width: 0.5,
        //     ),
        //   ),
        //   border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        // ),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 36,
        iconEnabledColor: Colors.deepOrange,
        //underline: SizedBox(),
        isExpanded: true,
        //value: selectedweghtItems.id,
        validator: (value) {
          if (value == null) {
            print(value);
            return 'الرجاء اختيار حجم الشيكارة';
          } else
            return null;
        },
        onTap: () {
          print('gggg');
        },
        //style: TextStyle(color: Colors.black),
        onChanged: (value) {
          // setState(() {
          //   _weghtId = value;
          // });
        },
        items: weghtItems
            .map(
              (e) => DropdownMenuItem(
                value: e.id.toInt(),
                onTap: () {
                  setState(() {
                    selectedweghtItems = e;
                  });

                  print('hjjhgfjhjhf${e.name}');
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    e.name.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                      //    fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        //     product.map((value) {
        //   return DropdownMenuItem(
        //     value: value,
        //     child: Text(
        //       value,
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   );
        // }).toList(),
      ),
    );
  }

  DropdownButtonFormField buildVanDriverContainer(BuildContext context) {
    return DropdownButtonFormField(
      style: TextStyle(
          //height: 0.1,
          color: Colors.white,
          fontFamily: 'beIN',
          fontWeight: FontWeight.bold,
          fontSize: 16),
      hint: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          'اختر عربية النقل',
          style: TextStyle(color: Colors.white54, fontSize: 17),
        ),
      ),
      dropdownColor: Colors.black87,
      elevation: 20,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 36,
      iconEnabledColor: Colors.deepOrange,
      // underline: SizedBox(),
      isExpanded: true,
      value: _vanId,
      //style: TextStyle(color: Colors.black),
      onChanged: (value) {
        print(value);
        setState(() {
          _vanId = value;

          // prodval = value;
          // productval = value;
          // if (productval == 'كل المنتجات') {
          //   productval = '';
          // }
        });
      },

      validator: (value) =>
          selectedvanDriver.isEmpty ? 'الرجاء اختيار عربية نقل' : null,
      items: vanDriver
          .map(
            (e) => DropdownMenuItem(
              value: e.id.toInt(),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(
                        primarySwatch: Colors.deepOrange,
                        unselectedWidgetColor: Colors.deepOrange,
                      ),
                      child: Checkbox(
                        hoverColor: Colors.deepOrange,
                        onChanged: (bool value) {
                          setState(() {
                            // sel.add()
                            if (value) {
                              selectedvanDriver
                                  .add(OrderCar(vId: e.id, driverName: e.name));
                              e.state = true;
                            } else {
                              // setState(() {
                              e.state = false;
                              selectedvanDriver
                                  .removeWhere((item) => item.vId == e.id);
                              // selectedvanDriver.removeWhere((item) {
                              //   item.vId = e.id;
                              //   return;
                              // });
                              // });
                            }
                          });
                        },
                        value: e.state, // sel[e.id - 3],
                      ),
                    ),
                    Text(
                      e.name.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                        //  fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
      //     product.map((value) {
      //   return DropdownMenuItem(
      //     value: value,
      //     child: Text(
      //       value,
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   );
      // }).toList(),
    );
  }
//   Expanded buildExpanded(int index) {
//     return Expanded(
//       child: Container(
//         //height: 90.0,
//         child: ListView.builder(
//           itemCount: index,
//           itemBuilder: (context, i) {
//             return Column(
//               //scrollDirection: Axis.vertical,
//               children: <Widget>[
//                 Wrow(
//                   lable: "اسم المنتج",
//                   val: '${widget.orderquantitysumquery[i].productName}',
//                 ),
//                 Wrow(
//                   lable: "وحده القياس",
//                   val: '${widget.orderquantitysumquery[i].measreName}',
//                 ),
//                 Wrow(
//                   lable: "الكمية",
//                   val: widget.orderquantitysumquery[i].sumQuantity.toString(),
//                 ),

//                 // Wrow(
//                 //   lable: "حالة العربية",
//                 //   val: getstate(
//                 //       widget.customertransquery[i].transVehcileHasOrderState),
//                 // ),
//                 Text(
//                   '__________________',
//                   style: TextStyle(
//                       color: Colors.orange[900],
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class Wrow extends StatefulWidget {
//   String lable;
//   String val;
//   Wrow({this.lable, this.val});

//   @override
//   _WrowState createState() => _WrowState();
// }

// class _WrowState extends State<Wrow> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
//           width: 190,
//           // padding: EdgeInsets.only(left: 0),
//           //color: const Color.fromRGBO(0, 51, 94, 1),
//           child: Text(
//             '${widget.val}',
//             style: TextStyle(color: Colors.white, fontSize: 14),
//             textAlign: TextAlign.right,
//           ),
//         ),
//         SizedBox(
//           width: 40,
//         ),
//         Container(
//           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//           width: 80,
//           // padding: EdgeInsets.only(left: 30),
//           // color: const Color.fromRGBO(0, 51, 94, 1),
//           child: Text(
//             '${widget.lable}',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontFamily: 'beIN',
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//       ],
//     );
//   }
// }

// class Lights extends StatefulWidget {
//   String lable;
//   String imgeurl;
//   String state;
//   Lights({this.lable, this.imgeurl, this.state});

//   @override
//   _LightsState createState() => _LightsState();
// }

// class _LightsState extends State<Lights> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       //mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         Container(
//           width: 90,

//           padding: EdgeInsets.only(left: 30),
//           //color: const Color.fromRGBO(0, 51, 94, 1),
//           child: Container(
//             margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
//             child: Image(
//               height: 30, // size.height * 0.2,
//               image: AssetImage(widget.imgeurl),
//             ),
//           ),
//           // Text(
//           //   '${widget.val}',
//           //   style: TextStyle(color: Colors.white, fontSize: 14),
//           // ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         Container(
//           //  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
//           width: 80,
//           // padding: EdgeInsets.only(left: 30),
//           // color: const Color.fromRGBO(0, 51, 94, 1),
//           child: Text(
//             '${widget.state}',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontFamily: 'beIN',
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//         SizedBox(
//           width: 70,
//         ),
//         Container(
//           width: 70,
//           // padding: EdgeInsets.only(left: 30),
//           // color: const Color.fromRGBO(0, 51, 94, 1),
//           child: Text(
//             '${widget.lable}',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontFamily: 'beIN',
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//         SizedBox(
//           width: 0,
//         ),
//       ],
//     );
//   }
}
