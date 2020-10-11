import 'package:maka/bloca/apiresponse.dart';

import 'package:maka/bloca/datarespotory.dart';

import 'package:maka/models/dropdownlist.dart';
import 'package:maka/utils/constant.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieModel extends Model {
  DatatRepository _dataRepository;

  ApiResponse<ApiResponse<DropDownList>> _data;

  ApiResponse<ApiResponse<DropDownList>> get dataList => _data;

  MovieModel() {
    //_data = ApiResponse();
    _dataRepository = DatatRepository();
    fetchDtatList();
  }

  fetchDtatList() async {
    _data = ApiResponse.loading('Fetching Popular Movies');
    notifyListeners();
    try {
      dropDownList = await _dataRepository.fetchData();
      _data = ApiResponse.completed(dropDownList);
      notifyListeners();
    } catch (e) {
      _data = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
