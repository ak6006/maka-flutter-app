import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:maka/screen/dashboard.dart';
import 'package:maka/screen/homepage.dart';
import 'package:maka/screen/login.dart';

import 'package:maka/screen/register.dart';
import 'package:maka/screen/splash.dart';
import 'package:maka/screen/vinpage.dart';

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
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
        var android =
            AndroidInitializationSettings('@mipmap-xhdpi/ic_launcher.png');
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
        print("onMessage: $message");
        final notification = message['notification'];
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
