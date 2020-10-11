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
    dataSink.add(ApiResponse.loading('Fetching Popular Movies'));

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

// class MovieBloc {
//   MovieRepository _movieRepository;
//   DatatRepository _datatRepository;

//   StreamController _movieListController;
//   StreamController _dataController;

//   StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
//       _movieListController.sink;

//   Stream<ApiResponse<List<Movie>>> get movieListStream =>
//       _movieListController.stream;

//   StreamSink<ApiResponse<DropDownList>> get dataSink => _dataController.sink;
//   Stream<ApiResponse<DropDownList>> get datastream => _dataController.stream;

//   MovieBloc() {
//     // _movieListController = StreamController<ApiResponse<List<Movie>>>();
//     // _movieRepository = MovieRepository();
//     // fetchMovieList();
//     _dataController = StreamController<ApiResponse<DropDownList>>();
//     _datatRepository = DatatRepository();
//     fetchdata();
//   }

//   fetchdata() async {
//     dataSink.add(ApiResponse.loading('Fetching Popular Movies'));
//     try {
//       DropDownList dropDownListv = await _datatRepository.fetchData();
//       dataSink.add(ApiResponse.completed(dropDownListv));
//     } catch (e) {
//       dataSink.add(ApiResponse.error(e.toString()));
//       print(e);
//     }
//   }

//   fetchMovieList() async {
//     movieListSink.add(ApiResponse.loading('Fetching Popular Movies'));
//     try {
//       List<Movie> movies = await _movieRepository.fetchMovieList();
//       movieListSink.add(ApiResponse.completed(movies));
//     } catch (e) {
//       movieListSink.add(ApiResponse.error(e.toString()));
//       print(e);
//     }
//   }

//   dispose() {
//     _movieListController?.close();
//     _dataController?.close();
//   }
// }
