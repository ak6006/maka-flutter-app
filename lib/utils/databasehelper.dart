import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:maka/bloca/appexcepcetion.dart';
import 'package:maka/models/vanmodel.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maka/utils/constant.dart';

// final prefs = SharedPreferences.getInstance();
/// DATABASE HELPER CLASS
class DatabaseHelper {
  //String serverUrl = "http://192.168.100.65:92";
  //String serverUrl = "http://ak772000842-001-site1.etempurl.com";
  String serverUrl = "http://teamiegypt-001-site1.atempurl.com/";
  //String serverip = "192.168.100.65:92";
  //String serverip = "ak772000842-001-site1.etempurl.com";
  String serverip = "teamiegypt-001-site1.atempurl.com";
  var status;
  var stateMsg;
  var codest;
  var connection;
  var token;

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  passwordCode(String phone) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      // status = true;
      // connection = true;
      status = 'conEr';
      return;
    }
    String myUrl = "$serverUrl/api/account/PassWordCode?PhoneNumber=$phone";
    final response = await http
        .post(myUrl, headers: {'Accept': 'application/json'}).then((response) {
      if (response.body.contains('invalid888888  ')) {
        status = 'error';
      } else
        status = 'con';
      print('valvalval${response.body}');
      return response.body;
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        // status = true;
        // connection = true;
        status = 'conEr';
        return null;
      },
    );
    // if (response == null) {
    //   status = true;
    //   connection = true;
    //   return;
    // } else {
    //   connection = false;
    // }

    // status = response.body.contains('error');

    // var data = json.decode(response.body);

    // if (status) {

    // } else {
    //   stateMsg = data["new_password"];

    // }
  }

  resetpassword(String phone, String code, String password) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      // status = true;
      // connection = true;
      status = 'conEr';
      return;
    }
    String myUrl = "$serverUrl/api/Account/ChangePassword";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "Phone": "$phone",
      "Code": "$code",
      "Password": "$password"
    }).then((response) {
      print("fasfas : ${response.body}");
      if (response.body.contains('expierd')) {
        status = 'expierd';
      } else if (response.body.contains('Phone')) {
        status = 'Phone';
      } else if (response.body.contains('Code')) {
        status = 'Code';
      } else if (response.body.contains('Done')) {
        status = 'Done';
      }
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        // status = true;
        // connection = true;
        status = 'conEr';
        return null;
      },
    );
    // if (response == null) {
    //   status = true;
    //   connection = true;
    //   return;
    // } else {
    //   connection = false;
    // }

    // status = response.body.contains('error');

    // var data = json.decode(response.body);

    // if (status) {

    // } else {
    //   stateMsg = data["new_password"];

    // }
  }

  loginData(String name, String password) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      // status = true;
      // connection = true;
      status = 'conEr';
      return;
    }
    String myUrl = "$serverUrl/login";
    var response;
    await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "UserName": "$name",
      "password": "$password",
      "grant_type": "password"
    }).then((responseE) {
      print(responseE.body);

      response = responseE;

      if (responseE.body.contains('error')) {
        status = 'error';
      } else {
        status = 'con';
        var data = json.decode(response.body);
        print('rolssssssss : ${data["roles"]}');
        if (data['roles'] == '["Customer"]') {
          customerRoles = true;
        } else
          customerRoles = false;
        if (customerRoles == false) {
          showToast();
        }

        print(customerRoles);
      }
      //return responseE;
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        // status = true;
        // connection = true;
        status = 'conEr';
        return null;
      },
    );
    // print(response);
    // if (response == null) {
    //   status = true;
    //   connection = true;
    //   return;
    // } else {
    //   connection = false;
    // }
    // return;

    bool statusv = response.body.contains('error');

    var data = json.decode(response.body);

    if (statusv) {
      print('data : ${data["error_description"]}');
      stateMsg = data["error_description"];
    } else {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
      await _save(data["access_token"]);
      mToken = data["access_token"];
      _firebaseMessaging.getToken().then((value) {
        setFirebaseToken(value);
      });
    }
    print('mmmmmmmmm$status');
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

  //==================================================================
  addproductData(dynamic data) async {
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

    String myUrl = "$serverUrl/api/Order/";
    codest = 0;
    final response1 = await http
        .post(myUrl,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'bearer $value'
            },
            body: jsonEncode(orders.map((e) => e.toJson()).toList()))
        .then((response) {
      codest = response.body;
      print(response.body);
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        connection = true;
        status = true;

        return null;
      },
    );

    return codest;
  }

//=================================================================
  //==================================================================
  addvanData(VanModel data) async {
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

    String myUrl = "$serverUrl/api/cars";
    codest = 0;
    final response1 = await http
        .post(myUrl,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'bearer $value'
            },
            body: jsonEncode(data.toJson()))
        .then((response) {
      codest = response.body;
      print(response.body);
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        connection = true;
        status = true;

        return null;
      },
    );

    return codest;
  }
//=================================================================

  deleteproductData(int data) async {
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

    String myUrl = "$serverUrl/api/Order?Orderid=$data";
    codest = 0;
    final response1 = await http.delete(myUrl, headers: {
      //'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $value'
    }).then((response) {
      codest = response.body;
      print(response.body);
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        connection = true;
        status = true;

        return null;
      },
    );
    // if (codest != 201) {
    //   status = true;
    //   connection = true;

    //   return;
    // } else {
    //   connection = false;
    //   status = false;
    // }
    return codest;
  }

  //==================================================================
  //=================================================================
  // registerData(String name, String mobile,
  //     String password /*,String confirmPass*/) async {
  //   var result;
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('connected');
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //     status = true;
  //     connection = true;
  //     return;
  //   }

  //   String myUrl = "$serverUrl/api/account/Register/";
  //   codest = 0;
  //   final response1 = await http.post(myUrl, headers: {
  //     'Accept': 'application/json'
  //   }, body: {
  //     "UserName": "$name",
  //     "PhoneNumber": "$mobile",
  //     "password": "$password",
  //     "ConfirmPassword": "$password",
  //   }).then((response) {
  //     codest = response.statusCode;
  //     print('mmmmamr ${response.body}');
  //     result = response.body;
  //   }).timeout(
  //     Duration(seconds: 10),
  //     onTimeout: () {
  //       connection = true;
  //       status = true;

  //       return null;
  //     },
  //   );
  //   if (codest != 201) {
  //     status = true;
  //     if (result.contains('taken') || result.contains('phone')) {
  //       connection = false;
  //     } else
  //       connection = true;

  //     return result;
  //   } else {
  //     //connection = false;
  //     if (result.contains('taken') || result.contains('phone')) {
  //       connection = true;
  //     } else
  //       connection = false;
  //     status = false;
  //     return result;
  //   }

  //   print(codest);
  // }
  registerData(String name, String mobile, String password) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      status = 'conEr';

      return status;
    }

    String myUrl = "$serverUrl/api/account/Register/";

    await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "UserName": "$name",
      "PhoneNumber": "$mobile",
      "password": "$password",
      "ConfirmPassword": "$password",
    }).then((response) {
      if (response.body.contains('taken')) {
        status = 'taken';
      } else if (response.body.contains('Phone')) {
        status = 'Phone';
      } else
        status = 'con';

      print(response.body);
    }).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        status = 'conEr';

        return status;
      },
    );
    return status;
  }

//==========================================================
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
      Duration(seconds: 15),
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
      //  await _saveCustomerName(data["CustomerName"]);

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

  showToast() {
    Fluttertoast.showToast(
        msg: "عفوا ..انت لست وكيل",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM // also possible "TOP" and "CENTER"
        );
  }
}
