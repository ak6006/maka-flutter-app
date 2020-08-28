import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String serverUrl =
      "http://192.168.100.21:92"; //"http://flutterapitutorial.codeforiraq.org/api";
  String serverip = "192.168.100.21:92";
  var status;
  var stateMsg;
  var codest;

  var token;

  // loginData(String name, String password) async {
  //   String myUrl = "$serverUrl/login";
  //   final response = await http.post(myUrl,
  //       headers: {'Accept': 'application/json'},
  //       body: {"UserName": "$name", "password": "$password"});
  //   status = response.body.contains('error');

  //   var data = json.decode(response.body);

  //   if (status) {
  //     print('data : ${data["error"]}');
  //   } else {
  //     print('data : ${data["token"]}');
  //     _save(data["token"]);
  //   }
  // }

  loginData(String name, String password) async {
    String myUrl = "$serverUrl/login";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "UserName": "$name",
      "password": "$password",
      "grant_type": "password"
    });
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error_description"]}');
      stateMsg = data["error_description"];
    } else {
      print('data : ${data["access_token"]}');
      _save(data["access_token"]);
    }
  }

  registerData(String name, String mobile, String password) async {
    String myUrl = "$serverUrl/api/account/Register/";
    codest = 0;
    final response1 = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      "UserName": "$name",
      "PhoneNumber": "$mobile",
      "password": "$password",
    }).then((response) {
      codest = response.statusCode;
      print(response.body);
    });
    print(codest);
    //status = response.body.contains('error');

    // var data = json.decode(response.body);

    // if (status) {
    //   print('data : ${data.toString}');
    // } else {
    //   print('data : ${data.toString}'); //["token"]
    //   // _save(data["token"]);
    // }
  }

  getData(String qrid) async {
    // final prefs = await SharedPreferences.getInstance();
    // final key = 'token';
    // final value = prefs.get(key) ?? 0;
    //String myUrl = "$serverUrl/account/Register";
    var queryParameters = {'Key': '$qrid'};
    var uri = Uri.http('$serverip', '/api/Values/Data/', queryParameters);

    String myUrl = serverUrl; // "$serverUrl/products/";
    // http.Response response = await http.get(myUrl, headers: {
    //   'Accept': 'application/json' //,
    //   // 'Authorization': 'Bearer $value'
    // });
    //  print(uri);
    //return 'ewafdsfdsdsfsggg';
    //
    var tdata;
    final response1 = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    ).then((response) {
      // print('Response status : ${response.statusCode}');
      //print('Response body : ${response.body}');
      tdata = response.body;

      // Map mapValue = json.decode(response.body);
      // print('Token value : ${mapValue.values.toString()}');
    });

    // print(response.body);
    // return response.body;
    return tdata;
  }

  void deleteData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/products/$id";
    http.delete(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void addData(String name, String price) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/products";
    http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$name",
      "price": "$price"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  void editData(int id, String name, String price) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://flutterapitutorial.codeforiraq.org/api/products/$id";
    http.put(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$name",
      "price": "$price"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }

  _saveUserData(String user, String pass) async {
    final prefs = await SharedPreferences.getInstance();
    final name = 'user';
    final nameval = user;
    prefs.setString(name, nameval);
    final pass = 'pass';
    final passval = pass;
    prefs.setString(pass, passval);
  }

  // _readUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'token';
  //   final value = token;
  //   prefs.setString(key, value);
  // }
}
