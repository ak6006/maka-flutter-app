import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maka/models/dropdownlist.dart';
//import 'package:maka/models/customertransquery.dart';
//import 'package:maka/models/orderQuntitySum.dart';
import 'package:maka/screen/addOrder.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/data_picker_style.dart';
import 'package:maka/utils/primary_text_field.dart';

// ignore: must_be_immutable
class UpdateOrderItemsScreen extends StatefulWidget {
  //List<CustomerTransQuery> customertransquery;
  // DropDownItem orderproductItems;
  CustomerOrder updateorders;
  UpdateOrderItemsScreen({this.updateorders});

  @override
  _UpdateOrderItemsScreenState createState() => _UpdateOrderItemsScreenState();
}

class _UpdateOrderItemsScreenState extends State<UpdateOrderItemsScreen> {
  final TextEditingController _quantity = new TextEditingController();

  DateTime timeEndSelected;
  DataPicker orderdate;
  int _weghtId;
  int _vanId = null;
  String quantity;
  DropDownItem selectedweghtItems = new DropDownItem();
  List<OrderCar> selectedvanDriver = [];
  @override
  void initState() {
    for (var h in vanDriver) {
      h.state = false;
      for (var s in widget.updateorders.orderCars) {
        if (h.id == s.vId) {
          h.state = true;
        }
      }
    }
    selectedweghtItems = DropDownItem(
        id: widget.updateorders.wieghtId,
        name: (widget.updateorders.wieghtName.toString()));
    quantity = widget.updateorders.quantity;
    selectedvanDriver.clear();
    for (var g in widget.updateorders.orderCars) {
      selectedvanDriver.add(OrderCar(vId: g.vId, driverName: g.driverName));
      //  e.state = value;
    }
    _vanId = vanDriver.first.id;

    orderdate = new DataPicker(
      dateTime: widget.updateorders.orderDate,
      lable: 'تاريخ الطلبية',
    );

    _quantity.text = widget.updateorders.quantity;
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
                    'تعديل طلبية ',
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

            Expanded(
              child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage(
                          'assets/images/${widget.updateorders.productId}.png',
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
                          widget.updateorders.productName,
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
                      child: PrimaryTextField(
                        label: ' الكمية بالطن',
                        onChanged: (value) {
                          quantity = value;

                          // _name = value.trim();
                          print("First text field: ${value.toInt()}");
                          //isValid = EmailValidator.validate(_email);
                        },
                        // validate: (String value) {
                        //   if (value.isEmpty) {
                        //     return 'الرجاء ادخال اسم المستخدم';
                        //   } //else if (isValid == false) {
                        //   //return 'Please enter a valid email';
                        //   //}
                        //   else {
                        //     return null;
                        //   }
                        // },
                        controller: _quantity,
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
                              //   print(int.parse(weghtItems[weghtItems
                              //               .indexOf(widget.orderproductItems)]
                              //           .name)
                              //       .toString());
                              //   return;
// var ff=weghtItems.indexOf(widget.orderproductItems);
                              // final hh = orders.where((i) {
                              //   i = widget.updateorders;
                              //   //
                              //   return;
                              // });
                              print(widget.updateorders.quantity);
                              print(orders.length);
                              int index = orders
                                  .indexWhere((t) => t == widget.updateorders);
                              // print(m);
                              orders[index].orderDate = orderdate.dateTime;
                              orders[index].wieghtId = selectedweghtItems.id;
                              orders[index].wieghtId = selectedweghtItems.id;

                              orders[index].wieghtName =
                                  int.parse(selectedweghtItems.name);

                              orders[index].quantity = quantity;
                              orders[index].orderCars = selectedvanDriver;
                              print(jsonEncode(
                                  orders.map((e) => e.toJson()).toList()));

                              //  return;
                              // orders.add(CustomerOrder(
                              //     orderId: 0,
                              //     orderHasProductId: 0,
                              //     orderDate: orderdate.dateTime,
                              //     productId: widget.orderproductItems.id,
                              //     productName: widget.orderproductItems.name,
                              //     wieghtId: selectedweghtItems.id,
                              //     wieghtName:
                              //         int.parse(selectedweghtItems.name),
                              //     measureId: measureItems[0].id,
                              //     measureName: measureItems[0].name,
                              //     quantity: quantity,
                              //     orderCars: selectedvanDriver));

                              // String jsonUser = jsonEncode(
                              //     orders[orders.length - 1].toJson());

                              //  return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddOrderScreen()), //FilterScreenPage()),
                              );
                            },
                            color: Color.fromRGBO(254, 88, 0, 1),
                            child: new Text(
                              'تعديل الطلب',
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
          ],
        ),
      ),
    );
  }

  Container buildWeghtContainer(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange[800], width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: DropdownButton(
              hint: Container(
                child: Text(
                  'اختار حجم الشكارة',
                  // textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              dropdownColor: Colors.black87,
              elevation: 20,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              iconEnabledColor: Colors.deepOrange,
              underline: SizedBox(),
              isExpanded: true,
              value: selectedweghtItems.id, //widget.updateorders.wieghtId,
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
          ),
        ),
      ),
    );
  }

  Container buildVanDriverContainer(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange[800], width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: DropdownButton(
              hint: Text(
                'اختر عربية النقل',
                style: TextStyle(color: Colors.orange),
              ),
              dropdownColor: Colors.black87,
              elevation: 20,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              iconEnabledColor: Colors.deepOrange,
              underline: SizedBox(),
              isExpanded: true,
              value: _vanId,
              // selectedvanDriver
              //     .first.vId, //widget.updateorders.orderCars[0].vId,
              //style: TextStyle(color: Colors.black),
              onChanged: (value) {
                print(value);
                setState(() {
                  _vanId = value;

                  // prodval = value;
                  //productval = value;
                  // if (productval == 'كل المنتجات') {
                  //   productval = '';
                  // }
                });
              },
              items: vanDriver
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id.toInt(),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          children: [
                            Checkbox(
                              hoverColor: Colors.indigo,
                              onChanged: (bool value) {
                                setState(() {
                                  // print(jsonEncode(selectedvanDriver
                                  //     .map((e) => e.toJson())
                                  //     .toList()));
                                  // sel.add()
                                  if (value) {
                                    selectedvanDriver.add(OrderCar(
                                        vId: e.id, driverName: e.name));
                                    e.state = value;
                                  } else {
                                    setState(() {
                                      e.state = false;
                                      selectedvanDriver.removeWhere(
                                          (item) => item.vId == e.id);
                                    });
                                  }
                                  // print(jsonEncode(selectedvanDriver
                                  //     .map((e) => e.toJson())
                                  //     .toList()));
                                });
                              },
                              value: e.state, // sel[e.id - 3],
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
            ),
          ),
        ),
      ),
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
