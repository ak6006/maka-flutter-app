import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:maka/models/customertransquery.dart';
import 'package:maka/utils/databasehelper.dart';

class CustomerTransPage extends StatefulWidget {
  CustomerTransPage({customertransquery});

  @override
  _CustomerTransPageState createState() => _CustomerTransPageState();
}

class _CustomerTransPageState extends State<CustomerTransPage> {
  List<CustomerTransQuery> customertransquery;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  DateTime choosedDate;
  bool isLoading = true;

  var list;
  var refreshkey = GlobalKey<RefreshIndicatorState>();

  getTrancations({date}) async {
    setState(() {
      isLoading = true;
    });
    dynamic result = await databaseHelper.getCustomerQueryData(date: date);
    print(result);
    customertransquery = customerTransQueryFromJson(result);
    print(customertransquery.length);
    // refreshList();
    setState(() {
      isLoading = false;
    });
  }

  Future<Null> refreshList() async {
    refreshkey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    dynamic result = await databaseHelper.getCustomerQueryData();
    print(result);
    customertransquery = customerTransQueryFromJson(result);
    print(customertransquery.length);
    // setState(() {
    //   databaseHelper.getCustomerQueryData();
    // });
    return null;
  }

  @override
  void initState() {
    initializeDateFormatting('ar');
    Intl.defaultLocale = 'ar';
    choosedDate = DateTime.now();
    print("init");
    getTrancations();
    print("called");
    refreshList();
    print('refreshed');

    super.initState();
  }

  //بيانات عربيات الوكيل
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
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
                    'بيانات عربيات الوكيل',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            FlatButton(
              //date time start
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true, minTime: DateTime(2018, 3, 5),
                    // maxTime: DateTime(2019, 6, 7),
                    onChanged: (date) {
                  print('change $date');
                }, onConfirm: (date) {
                  choosedDate = date;
                  getTrancations(date: date);
                }, currentTime: choosedDate, locale: LocaleType.ar);
              },
              child: Text(
                'بحث التاريخ',
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
            isLoading
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : buildExpanded(
                    customertransquery.length), // Datetime picker ends
            new Padding(
              padding: new EdgeInsets.only(top: 40.0),
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

  dynamic getstate(dynamic str, dynamic str2) {
    var re;

    // if (str == 0) {
    //   re = 'assets/images/red.png';
    // } else {
    //   re = 'assets/images/green.png';
    // }
    if (str == 'null' && str2 == 'null') {
      re = 'assets/images/red.png';
    } else if (str2 == 'null') {
      re = 'assets/images/yellow.png';
    } else {
      re = 'assets/images/green.png';
    }

    return re;
  }

  dynamic getstateval(dynamic str, dynamic str2) {
    var re;

    if (str == 'null' && str2 == 'null') {
      re = 'لم يتم التحميل';
    } else if (str2 == 'null') {
      re = 'جاري التحميل';
    } else {
      re = 'تم التحميل';
    }
    return re;
  }

  Expanded buildExpanded(int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        //height: 90.0,
        child: RefreshIndicator(
          key: refreshkey,
          // height: 50,
          color: Colors.deepOrange,
          backgroundColor: Colors.white,
          onRefresh: () async {
            await refreshList();
            setState(() {});
            print('refressssssssssssssssssssssssh');
          },
          child: ListView.builder(
            itemCount: index,
            itemBuilder: (context, i) {
              return Column(
                //scrollDirection: Axis.vertical,
                children: <Widget>[
                  Wrow(
                    lable: "رقم الطلبية",
                    val: '${customertransquery[i].orderId}',
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 300),
                    child: Wrow(
                      lable: "تاريخ الطلبية",
                      val: DateFormat("dd / MM / yyyy", 'ar')
                          .format(customertransquery[i].date),
                      direction: material.TextDirection.ltr,
                    ),
                  ),
                  Wrow(
                    lable: "اسم السائق",
                    val: customertransquery[i].transVehcileDriverName,
                  ),
                  Wrow(
                    lable: "رقم العربية",
                    val: customertransquery[i].transVehcileNum,
                  ),
                  Wrow(
                    lable: "المنتج",
                    val: customertransquery[i].productName,
                  ),
                  Wrow(
                    lable: "الكمية",
                    val: customertransquery[i].quantity.toString(),
                  ),
                  Wrow(
                    lable: "وحدة القياس",
                    val: customertransquery[i].measreName,
                  ),
                  Wrow(
                    lable: "بدء التحميل",
                    val: (customertransquery[i]
                                .orderHasProductInDate
                                .toString() ==
                            'null')
                        ? ''
                        : DateFormat(" EEEE dd / MM / yyyy  hh:mm a", 'ar')
                            .format(
                                customertransquery[i].orderHasProductInDate),
                    direction: material.TextDirection.rtl,
                  ),
                  Wrow(
                    lable: "انتهاء التحميل",
                    val: (customertransquery[i]
                                .orderHasProductOutDate
                                .toString() ==
                            'null')
                        ? ''
                        : DateFormat(" EEEE dd / MM / yyyy  hh:mm a", 'ar')
                            .format(
                                customertransquery[i].orderHasProductOutDate),
                    direction: material.TextDirection.rtl,
                    // : customertransquery[i].orderHasProductOutDate.toString(),
                  ),
                  Lights(
                    lable: 'حالة العربية',
                    imgeurl: getstate(
                        customertransquery[i].orderHasProductInDate.toString(),
                        customertransquery[i]
                            .orderHasProductOutDate
                            .toString()),
                    state: getstateval(
                        customertransquery[i].orderHasProductInDate.toString(),
                        customertransquery[i]
                            .orderHasProductOutDate
                            .toString()),
                  ),

                  // Wrow(
                  //   lable: "حالة العربية",
                  //   val: getstate(
                  //       customertransquery[i].transVehcileHasOrderState),
                  // ),
                  Text(
                    '__________________',
                    style: TextStyle(
                        color: Colors.orange[900],
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Wrow extends StatefulWidget {
  String lable;
  String val;
  material.TextDirection direction;
  Wrow({this.lable, this.val, this.direction = material.TextDirection.ltr});

  @override
  _WrowState createState() => _WrowState();
}

class _WrowState extends State<Wrow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: Container(
          // padding: EdgeInsets.only(left: 0),
          //color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.val}',
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.right,
          ),
        )),
        Container(
          width: 120,
          // padding: EdgeInsets.only(left: 30),
          // color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.lable}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'beIN',
            ),
            textDirection: widget.direction,
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          /// with of the all listview
          width: MediaQuery.of(context).size.width * 0.05,
        ),
      ],
    );
  }
}

class Lights extends StatefulWidget {
  String lable;
  String imgeurl;
  String state;
  Lights({this.lable, this.imgeurl, this.state});

  @override
  _LightsState createState() => _LightsState();
}

class _LightsState extends State<Lights> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
          //color: const Color.fromRGBO(0, 51, 94, 1),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Image(
              height: 30, // size.height * 0.2,
              image: AssetImage(widget.imgeurl),
            ),
          ),
          // Text(
          //   '${widget.val}',
          //   style: TextStyle(color: Colors.white, fontSize: 14),
          // ),
        ),
        // SizedBox(
        //     //    width: MediaQuery.of(context).size.width * 0.13,
        //     ),
        Container(
          //  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          width: MediaQuery.of(context).size.width * 0.28,
          // padding: EdgeInsets.only(left: 30),
          // color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.state}', // تم التحميل او جاري التحميل
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'beIN',
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
        ),
        Container(
          //width: MediaQuery.of(context).size.width * 0.17,
          // padding: EdgeInsets.only(left: 30),
          // color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text('${widget.lable}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'beIN',
              )),
        ),
        SizedBox(
          width: 0,
        ),
      ],
    );
  }
}
