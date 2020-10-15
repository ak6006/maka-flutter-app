import 'package:maka/bloca/apibaseheiper.dart';
import 'package:maka/models/dropdownlist.dart';
<<<<<<< HEAD

class DatatRepository {
  // final String _apiKey = "49ab266b67687a3409f15f794565a525";
  String serverUrl =
      "http://ak772000842-001-site1.etempurl.com/api/values/products";
=======
import 'package:maka/utils/constant.dart';

class DatatRepository {
  // final String _apiKey = "49ab266b67687a3409f15f794565a525";
  //String serverUrl = "/api/values/products";
>>>>>>> f1b41dfb01906add7f94ad088b788b338b054fae
//String myUrl = "$serverUrl/api/values/products";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DropDownList> fetchData() async {
<<<<<<< HEAD
    final response = await _helper.get(serverUrl);
    return DropDownList.fromJson(response);
  }
=======
    dynamic header = {
      'Accept': 'application/json',
      'Authorization': 'bearer $tokenapi'
    };
    final response = await _helper.get("/api/values/products", header);
    return DropDownList.fromJson(response);
  }

  Future login(String name, String password) async {
    dynamic header = {
      'Accept': 'application/json',
      'Authorization': 'bearer $tokenapi'
    };
    dynamic body = {
      "UserName": "$name",
      "password": "$password",
      "grant_type": "password"
    };

    final response = await _helper.post("/login", header, body);
    return response;
    //DropDownList.fromJson(response);
  }
>>>>>>> f1b41dfb01906add7f94ad088b788b338b054fae
}
