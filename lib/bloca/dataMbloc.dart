import 'dart:async';

import 'package:maka/bloca/apiresponse.dart';

import 'package:maka/bloca/datarespotory.dart';
import 'package:maka/models/dropdownlist.dart';
import 'package:maka/utils/constant.dart';

class DataBloc {
  DatatRepository _datatRepository;

  StreamController _dataController;

  StreamSink<ApiResponse<DropDownList>> get dataSink => _dataController.sink;
  Stream<ApiResponse<DropDownList>> get datastream => _dataController.stream;

  DataBloc() {
    _dataController = StreamController<ApiResponse<DropDownList>>();
    _datatRepository = DatatRepository();
    // fetchdata();
  }

  fetchdata() async {
    dataSink.add(ApiResponse.loading('Fetching Popular data'));

    try {
      DropDownList dropDownListv = await _datatRepository.fetchData();
      dataSink.add(ApiResponse.completed(dropDownListv));
      datastate = true;
    } catch (e) {
      dataSink.add(ApiResponse.error(e.toString()));
      print('vavaaa$e');
      datastate = false;
    }
  }

  dispose() {
    _dataController?.close();
  }
}
