import 'package:maka/bloca/apibaseheiper.dart';
import 'package:maka/models/dropdownlist.dart';
import 'package:maka/utils/constant.dart';

class DatatRepository {
  // final String _apiKey = "49ab266b67687a3409f15f794565a525";
  //String serverUrl = "/api/values/products";
//String myUrl = "$serverUrl/api/values/products";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DropDownList> fetchData() async {
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
}
