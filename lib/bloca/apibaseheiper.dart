import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maka/bloca/appecepcetion.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://api.themoviedb.org/3/";

  Future<dynamic> get(String url) async {
    var responseJson;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization':
            'bearer $value' //j3O7K3Ff2B0ihKxCDj_2xbfIpKn2FPApRWL2rLZYyj3eErsp2ArucmfVkvV4CSez79RWq9LYY2jgXHPM1Bj-1TcLYfkK4KDi4w2Eok2UDt3rAwG0_fG_o-kCxqfgBy_pdYN-U-Yv4aKVrZdjV4-HCXnwo-c1Fex0rHW8HNjwEC4clEzIKJzhDDQv-oMMVaVtkmWk6k9Uv6AE0M429YvCDaiemGFQgvWMTlwZTj4ajOI3QkKiR2JFz2bkKRbT4OqigL_Gs8xkHQnCcXfYjg22aIwdfxFLP5ffCeCL5nuCZhj1L9CVWTX9qeFlbWpzDYzIQseQxEug-956i0lSrzp5ZA'
      }); //_baseUrl +
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

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
}
