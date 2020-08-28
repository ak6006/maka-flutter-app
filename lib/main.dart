import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maka/screen/barcodescannr.dart';
import 'package:maka/screen/dashboard.dart';
import 'package:maka/screen/homepage.dart';
import 'package:maka/screen/login.dart';
import 'package:maka/screen/qrcode.dart';
import 'package:maka/screen/register.dart';
import 'package:maka/screen/vinpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maka High Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: MyHomePage(),
      // home: QrCode(
      //   qr: 'السريال' +
      //       '\n' +
      //       '127665443243353354' +
      //       '\n' +
      //       'تاريخ الانتاج' +
      //       '\n' +
      //       '8/7/2020',
      // ), //MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => new DashBoardPage(),
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
        '/register': (BuildContext context) => new RegisterPage(),
        '/login': (BuildContext context) => new LogIn(),
      },
    );
  }
}

// class MyApp1 extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
