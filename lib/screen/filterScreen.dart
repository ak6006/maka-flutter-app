import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:maka/bloca/apiresponse.dart';
import 'package:maka/models/orderQuntitySum.dart';

import 'package:maka/utils/animation.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/data_picker_style.dart';
import 'package:maka/utils/databasehelper.dart';

import 'orderQuantityScreen.dart';

class FilterScreenPage extends StatefulWidget {
  // List<ProductList> plist;
  //FilterScreenPage({this.plist});
  @override
  _FilterScreenPageState createState() => _FilterScreenPageState();
}

class _FilterScreenPageState extends State<FilterScreenPage> {
  DateTime timeBeginSelected;
  DateTime timeEndSelected;
  DataPicker begin;
  DataPicker end;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<OrderQuantitySumQuery> orderquantitysumquery;

  String title = 'DropDownButton';
  String _productsVal;
  int _prodId;
  String productval = '';
  List _products = [];
  @override
  void initState() {
    initializeDateFormatting('ar');
    Intl.defaultLocale = 'ar';
    begin = new DataPicker(
      dateTime: timeBeginSelected,
      lable: 'من تاريخ',
    );
    end = new DataPicker(
      dateTime: timeEndSelected,
      lable: 'الى تاريخ',
    );
    //List fixedList = widget.plist.asMap();
    productItems.clear();
    if (snapshotdata.data.status == Status.COMPLETED) {
      for (var h in dropDownList.prodNames) {
        _products.add(h.productName);
        productItems.add(DropDownItem(
            id: h.productId == 0 ? 0 : h.productId, name: h.productName));
        //print(productItems[1].name);
      }
    }
    // print('fggggg${fixedList[1]}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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
                    'استعلام عن مشريات وكيل',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            begin,
            SizedBox(
              height: 18.0,
            ),
            end,
            SizedBox(
              height: 5.0,
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 0.0),
            ),
            check(context),
            SizedBox(
              height: 18.0,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              decoration: BoxDecoration(
                // color: Color.fromRGBO(254, 88, 0, 1),
                borderRadius: BorderRadius.circular(60),
              ),
              height: 40,
              width: 160,
              child: new FlatButton(
                onPressed: () async {
                  //  DateFormat("yyy-mm-dd", 'en').format(begin.dateTime)
                  var result = await databaseHelper.getQantityData(
                      //   DateFormat.yMEd('en').format(begin.dateTime).toString(),
                      // DateFormat.yMEd('en').format(end.dateTime).toString(),
                      begin.dateTime.toString(),
                      end.dateTime.toString(),
                      productval.toString());

                  // var plist =
                  //               await databaseHelper.getProductData();
                  //plist.add('كل المنتجات');
                  //plist["c"] = 3
                  orderquantitysumquery = orderQuantitySumQueryFromJson(result);
                  // productlist.add('gffhfg');
                  //  print(orderquantitysumquery.length);
                  Navigator.push(
                    context,
                    MyCustomRoute(
                        builder: (context) => OrderQuantityScreen(
                              orderquantitysumquery: orderquantitysumquery,
                            )),
                  );

                  return;

                  //  Navigator.pushReplacementNamed(context, '/totalFilterResult');
                },
                color: Color.fromRGBO(254, 88, 0, 1),
                child: new Text(
                  'استعلام',
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'beIN',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18.0,
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
                  // print('vbn${productItems[2].name}');
                  print(begin.dateTime);
                  print(end.dateTime);
                  print(productval);
                  Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }

  Container check(BuildContext context) {
    if (snapshotdata.hasData) {
      switch (snapshotdata.data.status) {
        case Status.LOADING:
          return Container(
            height: 60,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
          break;
        case Status.COMPLETED:
          return buildproductDropDown(context);
          break;
        case Status.ERROR:
          return Container(
            child: Text(
              'لا يوجد اتصال بالسرفر',
              style: TextStyle(color: Colors.red),
            ),
          );
          break;
      }
    }
    return Container();
  }

  Container buildproductDropDown(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange[800], width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton(
              hint: Text(
                'اختر المنتج',
                style: TextStyle(color: Colors.white54),
              ),
              dropdownColor: Colors.black87,
              elevation: 20,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 36,
              iconEnabledColor: Colors.deepOrange,
              underline: SizedBox(),
              isExpanded: true,
              value: _productsVal,
              //style: TextStyle(color: Colors.black),
              onChanged: (value) {
                print(value);
                setState(() {
                  // _prodId = value;

                  _productsVal = value;
                  productval = value;
                  if (_productsVal == 'كل المنتجات') {
                    productval = '';
                  }
                });
              },
              items:
                  // productItems
                  //     .map(
                  //       (e) => DropdownMenuItem(
                  //         value: e.id.toInt(),
                  //         child: Text(
                  //           e.name.toString(),
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontFamily: 'beIN',
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //     .toList(),
                  _products.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
