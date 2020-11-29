import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:maka/bloca/apiresponse.dart';

import 'package:maka/models/dropdownlist.dart';
import 'package:maka/screen/dashboard.dart';
import 'package:maka/utils/constant.dart';

import 'package:maka/utils/databasehelper.dart';
import 'package:maka/utils/slideAnimations.dart';
import 'package:maka/utils/suggestions_text_field.dart';

class FeedPrices extends StatefulWidget {
  AsyncSnapshot<ApiResponse<DropDownList>> snapshot;
  FeedPrices({this.snapshot});
  @override
  _FeedPricesState createState() => _FeedPricesState();
}

class _FeedPricesState extends State<FeedPrices> {
  List<ProdName> productsInfo;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  bool isLoading = true;
  var list;
//  DataProvider dataProvider = DataProvider();
  getPrices() async {}
  void initState() {
    // dataProvider.setnewstate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // currentcontext = context;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(top: 20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 19),
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: 140.0,
                          child: Center(
                            child: Image(
                              height: 250,
                              image: AssetImage('assets/images/lg2.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      // padding: const EdgeInsets.only(left: 30),
                      width: 190,
                      alignment: Alignment.center,
                      color: Color.fromRGBO(254, 88, 0, 1),
                      child: new Text(
                        'الحلول و المقترحات',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'beIN',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  //height: size.height * 0.3,
                  width: size.width * 0.9,
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.deepOrange,
                  //     width: 3,
                  //   ),
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  child: new SuggestionsTextField(
                    label: 'اكتب الحلول او المقترحات هنا',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                ),
                Container(
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(254, 88, 0, 1),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  height: 40,
                  width: 160,
                  child: new FlatButton(
                    onPressed: () {
                      // return;
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => DashBoardPage()),
                      // );
                      // Navigator.push(
                      //     context, SlideRightRoute(page: DashBoardPage()));
                      alertDialog(DialogType.SUCCES, context,
                          'تمت العملية بنجاح', '', Icons.add, Colors.green);
                    },
                    color: Color.fromRGBO(254, 88, 0, 1),
                    child: new Text(
                      'تأكيد',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                ),
                Container(
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(254, 88, 0, 1),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  height: 40,
                  width: 160,
                  child: new FlatButton(
                    onPressed: () {
                      // return;
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => DashBoardPage()),
                      // );
                      Navigator.push(
                          context, SlideRightRoute(page: DashBoardPage()));
                    },
                    color: Color.fromRGBO(254, 88, 0, 1),
                    child: new Text(
                      'رجوع',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
