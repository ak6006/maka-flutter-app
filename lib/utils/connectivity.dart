// import 'dart:io'; //InternetAddress utility
// import 'dart:async'; //For StreamController/Stream

// import 'package:connectivity/connectivity.dart';

// class ConnectionStatusSingleton {
//   //This creates the single instance by calling the `_internal` constructor specified below
//   static final ConnectionStatusSingleton _singleton =
//       new ConnectionStatusSingleton._internal();
//   ConnectionStatusSingleton._internal();

//   //This is what's used to retrieve the instance through the app
//   static ConnectionStatusSingleton getInstance() => _singleton;

//   //This tracks the current connection status
//   bool hasConnection = false;

//   //This is how we'll allow subscribing to connection changes
//   StreamController connectionChangeController =
//       new StreamController.broadcast();

//   //flutter_connectivity
//   final Connectivity _connectivity = Connectivity();

//   //Hook into flutter_connectivity's Stream to listen for changes
//   //And check the connection status out of the gate
//   void initialize() {
//     _connectivity.onConnectivityChanged.listen(_connectionChange);
//     checkConnection();
//   }

//   Stream get connectionChange => connectionChangeController.stream;

//   //A clean up method to close our StreamController
//   //   Because this is meant to exist through the entire application life cycle this isn't
//   //   really an issue
//   void dispose() {
//     connectionChangeController.close();
//   }

//   //flutter_connectivity's listener
//   void _connectionChange(ConnectivityResult result) {
//     checkConnection();
//   }

//   //The test to actually see if there is a connection
//   Future<bool> checkConnection() async {
//     bool previousConnection = hasConnection;

//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         hasConnection = true;
//       } else {
//         hasConnection = false;
//       }
//     } on SocketException catch (_) {
//       hasConnection = false;
//     }

//     //The connection status changed send out an update to all listeners
//     if (previousConnection != hasConnection) {
//       connectionChangeController.add(hasConnection);
//     }

//     return hasConnection;
//   }
// }

// import 'package:connectivity/connectivity.dart';

// class NetworkCheck {
//   Future<bool> check() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.mobile) {
//       return true;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       return true;
//     }
//     return false;
//   }

//   dynamic checkInternet(Function func) {
//     check().then((intenet) {
//       if (intenet != null && intenet) {
//         func(true);
//       } else {
//         func(false);
//       }
//     });
//   }
// }

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectionClass {
  _checkInternetConnectivity(context) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog('No internet', "You're not connected to a network", context);
    }
    // else if (result == ConnectivityResult.mobile) {
    //   _showDialog('Internet access', "You're connected over mobile data");
    // } else if (result == ConnectivityResult.wifi) {
    //   _showDialog('Internet access', "You're connected over wifi");
    // }
  }

  _showDialog(title, text, context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
