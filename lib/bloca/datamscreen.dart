import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maka/bloca/apiresponse.dart';
import 'package:maka/bloca/dataMbloc.dart';
import 'package:maka/bloca/dataresponse.dart';
import 'package:maka/models/dropdownlist.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  DataBloc _bloc;
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _bloc = DataBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Mania')),
      backgroundColor: Colors.black54,
      body: Container(
        child:
            //BlocProvider(
            //   create: (context) => SubjectBloc(),
            //   child: Container(),
            // ),
            RefreshIndicator(
          color: Colors.green,
          backgroundColor: Colors.yellow,
          key: refreshkey,
          onRefresh: () => _bloc.fetchdata(), //fetchMovieList(),
          child: StreamBuilder<ApiResponse<DropDownList>>(
            //List<Movie>
            stream: _bloc.datastream, //movieListStream
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    // return Loading(
                    //   loadingMessage: snapshot.data.message,
                    // );
                    return Text(
                      'loading',
                      style: TextStyle(color: Colors.white),
                    );
                    break;
                  case Status.COMPLETED:
                    print(snapshot.data.data.measureNames[0].measureName);
                    //  snapshot.data.data.custName.custName
                    return new Container(
                      //   height: 60,
                      child: new Image.memory(
                        Base64Codec()
                            .decode(snapshot.data.data.gifts[2].giftimg),
                        // fit: BoxFit.fitWidth,
                        // width: double.infinity,
                      ),
                    );
                    // Text(
                    //   snapshot.data.data.prodNames
                    //       .map((e) => e.price)
                    //       .toList()
                    //       .toString(),
                    //   style: TextStyle(color: Colors.white),
                    // );
                    //return MovieList(movieList: snapshot.data.data);

                    break;
                  case Status.ERROR:
                    print('error');
                    return Text(
                      snapshot.data.message.toString(),
                      style: TextStyle(color: Colors.white),
                    );
                    // return Error(
                    //   errorMessage: snapshot.data.message,
                    //   onRetryPressed: () => _bloc.fetchMovieList(),
                    // );
                    break;
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
