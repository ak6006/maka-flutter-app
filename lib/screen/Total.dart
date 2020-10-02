// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as material;
// import 'package:flutter/rendering.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'package:maka/models/DropDownData.dart';
// import 'dart:convert';

// import 'package:maka/models/customertransquery.dart';
// import 'package:maka/utils/databasehelper.dart';

// class Total extends StatefulWidget {
//   //Total({customertransquery});

//   @override
//   _TotalState createState() => _TotalState();
// }

// class _TotalState extends State<Total> {
//   List<DropDownData> dropdownmenu, listOfProducts;
//   //List<DropDownData> listOfProducts;
//   DateTime _dateFrom = new DateTime.now();
//   DateTime _dateTo = new DateTime.now();

//   Future<Null> _selectDateFrom(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: _dateFrom,
//         firstDate: new DateTime(2018),
//         lastDate: new DateTime(2025));

//     if (picked != null && picked != _dateFrom) {
//       print('Date Selected : ${_dateFrom.toString()}');
//       setState(() {
//         _dateFrom = picked;
//       });
//     }
//   }

//   Future<Null> _selectDateTo(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: _dateTo,
//         firstDate: new DateTime(2018),
//         lastDate: new DateTime(2025));

//     if (picked != null && picked != _dateTo) {
//       print('Date Selected : ${_dateTo.toString()}');
//       setState(() {
//         _dateTo = picked;
//       });
//     }
//   }

//   List<CustomerTransQuery> customertransquery;
//   DatabaseHelper databaseHelper = new DatabaseHelper();
//   DateTime choosedDate;
//   bool isLoading = true;

//   // getTrancations({date}) async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   dynamic result = await databaseHelper.getCustomerQueryData(date: date);
//   //   print(result);
//   //   customertransquery = customerTransQueryFromJson(result);
//   //   print(customertransquery.length);
//   //   // refreshList();
//   //   setState(() {
//   //     isLoading = false;
//   //   });
//   // }

//   DropDownData _dropDownData;

//   // String _mySelection;
//   //String serverUrl = "http://ak772000842-001-site1.etempurl.com";
//   final String MyUrl =
//       "http://ak772000842-001-site1.etempurl.com/api/values/products";

//   Future<List<DropDownData>> _fetchData() async {
//     //var response = await http.get(MyUrl);

//     var response =
//         await http.get(MyUrl, headers: {'Accept': 'application/json'});
//     if (response.statusCode == 200) {
//       print(response.statusCode);
//       final items = json.decode(response.body).cast<Map<String, dynamic>>();
//       listOfProducts = items.map<DropDownData>((json) {
//         return DropDownData.fromJson(json);
//       }).toList();
//       print('ssssssssssssssss${listOfProducts[1].productName}');
//       return listOfProducts;
//     } else {
//       throw Exception('Failed to load internet');
//     }
//   }

//   String title = 'DropDownButton';
//   String _productsVal;
//   List _products = [];
//   // 'منتج 1',
//   // 'منتج 2',
//   // 'منتج 3',
//   // 'منتج 4',
//   // 'منتج 5',
//   // 'منتج 6',
//   // 'منتج 7'

//   @override
//   void initState() {
//     initializeDateFormatting('ar');
//     Intl.defaultLocale = 'ar';
//     choosedDate = DateTime.now();
//     print("init");
//     dropMenuMethod();
//     // getTrancations();
//     // print("called");
//     super.initState();
//   }

//   dropMenuMethod() async {
//     dropdownmenu = await _fetchData();
//     print('lengthhhhhhhhh${dropdownmenu.length}');
//     for (var h in dropdownmenu) {
//       _products.add(h.productName);
//       print(h.productName);
//     }
//   }

//   //بيانات عربيات الوكيل
//   Widget build(BuildContext context) {
//     //final size = MediaQuery.of(context).size;
//     return Scaffold(
//       //backgroundColor: Color.fromRGBO(0, 51, 94, 1),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/back.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             new Padding(
//               padding: new EdgeInsets.only(top: 20.0),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.only(left: 19),
//                   child: Hero(
//                     tag: 'logo',
//                     child: Container(
//                       height: 140.0,
//                       child: Center(
//                         child: Image(
//                           height: 250,
//                           image: AssetImage('assets/images/lg2.jpg'),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   // padding: const EdgeInsets.only(left: 30),
//                   width: 190,
//                   alignment: Alignment.center,
//                   color: Color.fromRGBO(254, 88, 0, 1),
//                   child: new Text(
//                     'اجماليات مشتريات وكيل',
//                     style: new TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'beIN',
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(254, 88, 0, 1),
//                     borderRadius: BorderRadius.circular(60),
//                   ),
//                   child: FlatButton(
//                       child: Text(
//                         'التاريخ من',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         _selectDateFrom(context);
//                       }),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.03,
//                 ),
//                 Text(
//                   'من : ${_dateFrom.toString()}',
//                   //DateFormat("dd / MM / yyyy", 'ar'),
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.02),
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(254, 88, 0, 1),
//                     borderRadius: BorderRadius.circular(60),
//                   ),
//                   child: FlatButton(
//                       child: Text(
//                         'التاريخ الي',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         _selectDateTo(context);
//                       }),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.03,
//                 ),
//                 Text(
//                   'الي : ${_dateTo.toString()}',
//                   //DateFormat("dd / MM / yyyy", 'ar'),
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.03),
//                   child: Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.deepOrange, width: 2),
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: DropdownButton(
//                           hint: Text(
//                             'اختر المنتج',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           dropdownColor: Colors.deepOrange,
//                           elevation: 20,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 36,
//                           iconEnabledColor: Colors.deepOrange,
//                           underline: SizedBox(),
//                           isExpanded: true,
//                           value: _productsVal,
//                           //style: TextStyle(color: Colors.black),
//                           onChanged: (value) {
//                             setState(() {
//                               _productsVal = value;
//                             });
//                           },

//                           items: _products.map((value) {
//                             return DropdownMenuItem(
//                               value: value,
//                               child: Text(
//                                 value,
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.05),
//                   decoration: BoxDecoration(
//                     // color: Color.fromRGBO(254, 88, 0, 1),
//                     borderRadius: BorderRadius.circular(60),
//                   ),
//                   height: 40,
//                   width: 160,
//                   child: new FlatButton(
//                     onPressed: () {
//                       Navigator.pushReplacementNamed(
//                           context, '/totalFilterResult');
//                     },
//                     color: Color.fromRGBO(254, 88, 0, 1),
//                     child: new Text(
//                       'استعلام',
//                       style: new TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'beIN',
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             new Padding(
//               padding: new EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.03),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 // color: Color.fromRGBO(254, 88, 0, 1),
//                 borderRadius: BorderRadius.circular(60),
//               ),
//               height: 40,
//               width: 160,
//               child: new FlatButton(
//                 onPressed: () {
//                   Navigator.pushReplacementNamed(context, '/dashboard');
//                 },
//                 color: Color.fromRGBO(254, 88, 0, 1),
//                 child: new Text(
//                   'رجوع',
//                   style: new TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'beIN',
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Expanded buildExpanded(int index) {
//   //   return Expanded(
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(8.0),
//   //       child: Container(
//   //         // margin: EdgeInsets.symmetric(
//   //         //     horizontal: MediaQuery.of(context).size.width * 0.05),
//   //         //height: 90.0,
//   //         // child: ListView.builder(
//   //         //   itemCount: index,
//   //         //   itemBuilder: (context, i) {},
//   //         // ),
//   //         child: Column(
//   //           children: [],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
