import 'dart:async';

import 'package:flutter/material.dart';
import 'homepage.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // DatabaseHelper _dbHelper = DatabaseHelper();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //bool loggedIn = await _dbHelper.isLoggedIn();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushNamed(context, '/MyHomePage'),
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
      // ),
    );
    //  loggedIn ? DashBoardPage() : MyHomePage())));
    //});
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/mar7aba.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }
}
