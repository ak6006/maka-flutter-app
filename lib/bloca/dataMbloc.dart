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
<<<<<<< HEAD
    fetchdata();
  }

  fetchdata() async {
    dataSink.add(ApiResponse.loading('Fetching Popular Movies'));
=======
    // fetchdata();
  }

  fetchdata() async {
    dataSink.add(ApiResponse.loading('Fetching Popular data'));
>>>>>>> f1b41dfb01906add7f94ad088b788b338b054fae

    try {
      DropDownList dropDownListv = await _datatRepository.fetchData();
      dataSink.add(ApiResponse.completed(dropDownListv));
<<<<<<< HEAD
=======

>>>>>>> f1b41dfb01906add7f94ad088b788b338b054fae
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
