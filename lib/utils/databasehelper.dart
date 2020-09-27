import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// DATABASE HELPER CLASS
class DatabaseHelper {
  //String serverUrl = "http://192.168.100.65:92";
  String serverUrl = "http://ak772000842-001-site1.etempurl.com";
  //String serverip = "192.168.100.65:92";
  String serverip = "ak772000842-001-site1.etempurl.com";
  var status;
  var stateMsg;
  var codest;
  var connection;
  var token;

  loginData(String name, String password) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }
    String myUrl = "$serverUrl/login";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "UserName": "$name",
      "password": "$password",
      "grant_type": "password"
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = true;
        connection = true;

        return null;
      },
    );
    if (response == null) {
      status = true;
      connection = true;
      return;
    } else {
      connection = false;
    }

    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error_description"]}');
      stateMsg = data["error_description"];
    } else {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
      await _save(data["access_token"]);
      _firebaseMessaging.getToken().then((value) {
        setFirebaseToken(value);
      });
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    if ((prefs.getString(key) ?? "") != "")
      return true;
    else
      return false;
  }

  setFirebaseToken(String token) async {
    {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
        }
      } on SocketException catch (_) {
        print('not connected');
        status = true;
        connection = true;
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      final key = 'access_token';
      final value = prefs.get(key) ?? 0;

      var queryParameters = {'DeviceToken': '$token'};
      var uri =
          Uri.http('$serverip', '/api/UpdateUserToken/Update', queryParameters);

      // String myUrl = serverUrl; // "$serverUrl/products/";

      var tdata;
      final response1 = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $value'
        },
      ).then((response) {
        tdata = response.body;
      }).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          status = true;
          connection = true;

          return null;
        },
      );

      return tdata;
    }
  }

  registerData(String name, String mobile,
      String password /*,String confirmPass*/) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }

    String myUrl = "$serverUrl/api/account/Register/";
    codest = 0;
    final response1 = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "UserName": "$name",
      "PhoneNumber": "$mobile",
      "password": "$password",
      "ConfirmPassword": "$password",
    }).then((response) {
      codest = response.statusCode;
      print(response.body);
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        connection = true;
        status = true;

        return null;
      },
    );
    if (codest != 201) {
      status = true;
      connection = true;

      return;
    } else {
      connection = false;
      status = false;
    }
    print(codest);
  }

  getQantityData(String bdate, String edate, String product) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    var queryParameters = {
      'beginDate': '$bdate',
      'endDate': '${edate}',
      'ProductName': '${product}'
    };
    var uri = Uri.http('$serverip', '/api/Payment/', queryParameters);

    // return;
//  String myUrl = "$serverUrl/api/Payment/beginDate=" +
//           DateFormat("M/d/yyyy", 'en').format(date) +
//           " 12:00:00 AM";
    String myUrl = "$serverUrl/api/Payment/?beginDate=" +
        bdate +
        '&' +
        'endDate=' +
        edate +
        '&' +
        'ProductName=$product';
    print(myUrl);
    // String myUrl = serverUrl; // "$serverUrl/products/";

    var tdata;
    final response1 = await http.get(
      myUrl,
      headers: {'Accept': 'application/json', 'Authorization': 'bearer $value'},
    ).then((response) {
      tdata = response.body;
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = true;
        connection = true;

        return null;
      },
    );
    print(tdata);

    return tdata;
  }

  getData(String qrid) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    var queryParameters = {'Key': '$qrid'};
    var uri = Uri.http('$serverip', '/api/Values/Data/', queryParameters);

    // String myUrl = serverUrl; // "$serverUrl/products/";

    var tdata;
    final response1 = await http.get(
      uri,
      headers: {'Accept': 'application/json', 'Authorization': 'bearer $value'},
    ).then((response) {
      tdata = response.body;
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = true;
        connection = true;

        return null;
      },
    );

    return tdata;
  }

  getProductData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;

    //var queryParameters = {'Key': '$qrid'};
    //var uri = Uri.http('$serverip', '/api/Values/Data/', queryParameters);

    String myUrl = "$serverUrl/api/values/products";

    var tdata;
    final response1 = await http.get(
      myUrl,
      headers: {'Accept': 'application/json', 'Authorization': 'bearer $value'},
    ).then((response) {
      tdata = response.body;
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = true;
        connection = true;

        return null;
      },
    );
    print(tdata);

    return tdata;
  }

  getQueryData(String qrid) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    //String myUrl = "$serverUrl/account/Register";
    var queryParameters = {'Key': '$qrid'};
    var uri = Uri.http('$serverip', '/api/trans/transData', queryParameters);

    String myUrl = serverUrl; // "$serverUrl/products/";

    var tdata;
    final response1 = await http.get(
      uri,
      headers: {'Accept': 'application/json', 'Authorization': 'bearer $value'},
    ).then((response) {
      tdata = response.body;
      print('sssss$value');
      print(response.body);
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = true;
        connection = true;

        return null;
      },
    );

    return tdata;
  }

  getCustomerQueryData({DateTime date}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    print(value);
    String myUrl = "";
    if (date == null)
      myUrl = "$serverUrl/api/custtrans/get";
    else
    // myUrl = "https://localhost:44328/api/transhistory/data?key=" + date;
    {
      // print(DateFormat("M/d/yyyy").format(date) + " 12:00:00 AM");
      myUrl = "$serverUrl/api/transhistory/data?Key=" +
          DateFormat("M/d/yyyy", 'en').format(date) +
          " 12:00:00 AM";
      print(myUrl);
    }
    var tdata;
    final response1 = await http.get(
      myUrl,
      headers: {'Accept': 'application/json', 'Authorization': 'bearer $value'},
    ).then((response) {
      tdata = response.body;
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = true;
        connection = true;

        return null;
      },
    );
    return tdata;
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }

  readLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final keyUser = 'user';
    final keyPass = 'pass';
    final valueUser = prefs.get(keyUser) ?? '';
    final valuePass = prefs.get(keyPass) ?? '';
    print('read : $valueUser');
    print('read : $valuePass');
  }

  saveUserData(String user, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final name = 'user';
    final nameval = user;
    prefs.setString(name, nameval);
    final pass1 = 'pass';
    final passval = password;
    prefs.setString(pass1, passval);
  }

  getCustomerQueryDataWithRefresh({DateTime date}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    print(value);
    String myUrl = "";
    (date == null);
    myUrl = "$serverUrl/api/custtrans/get";
    var tdata;
    final response1 = await http.get(
      myUrl,
      headers: {'Accept': 'application/json', 'Authorization': 'bearer $value'},
    ).then((response) {
      tdata = response.body;
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = true;
        connection = true;

        return null;
      },
    );
    return tdata;
  }

  getCustomerName() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = true;
      connection = true;
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    print(value);
    String myUrl = "";

    myUrl = "$serverUrl/api/Values/CustomerName";

    print(myUrl);
    var tdata;
    final response1 = await http.get(
      myUrl,
      headers: {'Accept': 'application/json', 'Authorization': 'bearer $value'},
    ).then((response) {
      tdata = response.body;
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = true;
        connection = true;

        return null;
      },
    );
    status = tdata.contains('error');

    var data = json.decode(tdata);

    if (status) {
      // print('data : ${data["error_description"]}');
      // stateMsg = data["error_description"];
    } else {
      // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
      await _saveCustomerName(data["CustomerName"]);

      // _firebaseMessaging.getToken().then((value) {
      //   setFirebaseToken(value);
      // });
    }
    return tdata;
  }

  //-----------------------------
  _saveCustomerName(String customerName) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'CustomerName';
    final value = customerName;
    prefs.setString(key, value);
  }
}
