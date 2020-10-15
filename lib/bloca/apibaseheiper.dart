import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:maka/bloca/appexcepcetion.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    var responseJson;
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key) ?? 0;
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'bearer $value'
      });
=======

class ApiBaseHelper {
  final String _baseUrl = 'http://ak772000842-001-site1.etempurl.com';
  Future<dynamic> get(String url, dynamic headers) async {
    var responseJson;

    try {
      final response = await http.get(_baseUrl + url, headers: headers);
>>>>>>> f1b41dfb01906add7f94ad088b788b338b054fae
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

<<<<<<< HEAD
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
=======
  Future<dynamic> post(String url, dynamic headers, dynamic body) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final response =
          await http.post(_baseUrl + url, headers: headers, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url);
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
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
>>>>>>> f1b41dfb01906add7f94ad088b788b338b054fae
  }
}
