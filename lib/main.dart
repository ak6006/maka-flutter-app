import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:maka/bloca/apiresponse.dart';

import 'package:maka/bloca/dataMbloc.dart';

import 'package:maka/gift/giftDashBoard.dart';
import 'package:maka/models/dropdownlist.dart';
import 'package:maka/screen/FeedPrices.dart';

import 'package:maka/screen/dashboard.dart';
import 'package:maka/screen/homepage.dart';
import 'package:maka/screen/login.dart';

import 'package:maka/screen/register.dart';
import 'package:maka/screen/splash.dart';
import 'package:maka/screen/vinpage.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/screen/addOrder.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String title = '';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  void showNotification(flp, {title, message}) async {
    var android = AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    await flp.show(0, title, message, platform);
  }

  @override
  void dispose() {
    blocData.dispose();
    super.dispose();
  }

  Timer _timer;
  @override
  void initState() {
    super.initState();
    blocData = DataBloc();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // var data = json.decode(message.toString());
        print("onMessage: xxxxxxx${message}"); //["notification"]["body"]
        if (message["notification"]["body"].length == 4) {
          //  print("ggggggggggg");

          passwordCode = message["notification"]["body"];
        }
        final notification = message['notification'];
        FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
        var android =
            AndroidInitializationSettings('assets/images/ic_launcher.png');
        var iOS = IOSInitializationSettings();
        var initSetttings = InitializationSettings(android, iOS);
        flp.initialize(initSetttings);
        showNotification(flp,
            title: notification['title'], message: notification['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
      },
      onResume: (Map<String, dynamic> message) async {
        print("onMessage:aaaaaaaa $message");
        final notification = message['notification'];
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _initializeTimer();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(const Duration(minutes: 20), (_) => _logOutUser());

    print('intializeTimer');
  }

  void _logOutUser() {
    // Navigator.of(ContextClass.CONTEXT)
    //     .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => true);
    //Navigator.pushReplacementNamed(context, '/MyHomePage');
    // Log out the user if they're logged in, then cancel the timer.
    // You'll have to make sure to cancel the timer if the user manually logs out
    // and to call _initializeTimer once the user logs in
    print('timer execution');

    _timer.cancel();
  }

  // You'll probably want to wrap this function in a debounce
  void _handleUserInteraction([_]) {
    print('interaction');
    if (!_timer.isActive) {
      // This means the user has been logged out
      return;
    }

    _timer.cancel();
    _initializeTimer();
  }

  @override
  Widget build(BuildContext context) {
    ContextClass.CONTEXT = context;
    currentcontext = context;
    return
        // ChangeNotifierProvider<DataProvider>(

        //   //  builder:(context) => DataProvider() ,
        //   create: (BuildContext context) => DataProvider(),

        //   // value: AuthServices().user,
        //   child:
        StreamBuilder<ApiResponse<DropDownList>>(
            stream: blocData.datastream,
            builder: (context, snapshot) {
              snapshotdata = snapshot;
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _handleUserInteraction,
                onPanDown: _handleUserInteraction,
                onScaleStart: _handleUserInteraction,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Maka High Feed',
                  theme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    fontFamily: 'Roboto',
                  ),
                  home: Splash(),
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
                    '/vinpage': (BuildContext context) => new VinPage(),
                    '/MyHomePage': (BuildContext context) => new MyHomePage(),
                    '/register': (BuildContext context) => new RegisterPage(),
                    '/login': (BuildContext context) => new LogIn(),
                    '/FeedPrices': (BuildContext context) => new FeedPrices(),
                    '/giftscreen': (BuildContext context) =>
                        new GiftDashBoardScreen(),
                    '/addorder': (BuildContext context) => new AddOrderScreen(),
                  },
                ),
              );
            });
  }
}

class ContextClass {
  static BuildContext CONTEXT;
}
