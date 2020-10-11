import 'package:maka/bloca/apibaseheiper.dart';
import 'package:maka/models/dropdownlist.dart';

class DatatRepository {
  // final String _apiKey = "49ab266b67687a3409f15f794565a525";
  String serverUrl =
      "http://ak772000842-001-site1.etempurl.com/api/values/products";
//String myUrl = "$serverUrl/api/values/products";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DropDownList> fetchData() async {
    final response = await _helper.get(serverUrl);
    return DropDownList.fromJson(response);
  }
}
