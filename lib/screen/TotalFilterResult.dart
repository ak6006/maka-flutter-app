// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as material;
// import 'package:flutter/rendering.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';

// import 'package:maka/models/customertransquery.dart';
// import 'package:maka/utils/databasehelper.dart';

// class TotalFilterResult extends StatefulWidget {
//   //Total({customertransquery});

//   @override
//   _TotalFilterResultState createState() => _TotalFilterResultState();
// }

// class _TotalFilterResultState extends State<TotalFilterResult> {
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
//                     'نتائج الفيلتر',
//                     style: new TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'beIN',
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             new Padding(
//               padding: new EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.6),
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
//                   Navigator.pushReplacementNamed(context, '/total');
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
// }
