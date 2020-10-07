import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:maka/models/transquery.dart';
//import 'package:flutter/material.dart' as material;

class TransVanPage extends StatefulWidget {
  List<TransQuery> transquery;
  TransVanPage({this.transquery});

  @override
  _TransVanPageState createState() => _TransVanPageState();
}

class _TransVanPageState extends State<TransVanPage> {
  @override
  void initState() {
    initializeDateFormatting('ar');
    Intl.defaultLocale = 'ar';
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
                    'بيانات عربيات النقل',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            buildExpanded(widget.transquery.length),
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

  Expanded buildExpanded(int index) {
    return Expanded(
      child: Container(
        //height: 90.0,
        child: ListView.builder(
          itemCount: index,
          itemBuilder: (context, i) {
            return Column(
              //scrollDirection: Axis.vertical,
              children: <Widget>[
                Wrow(
                  lable: "رقم الطلبية",
                  val: '${widget.transquery[i].orderId}',
                ),
                Wrow(
                  lable: "اسم السائق",
                  val: widget.transquery[i].transVehcileDriverName,
                ),
                Wrow(
                  lable: "اسم الوكيل",
                  val: widget.transquery[i].firstName,
                ),
                Wrow(
                  lable: "التاريخ",
                  val: DateFormat("dd / MM / yyyy", 'ar')
                      .format(widget.transquery[i].date),
                ),
                Wrow(
                  lable: "اسم المنتج",
                  val: '${widget.transquery[i].productName}',
                ),
                Wrow(
                  lable: "الوزن",
                  val: '${widget.transquery[i].weightNet}',
                ),
                Wrow(
                  lable: "عدد شكاير",
                  val: '${widget.transquery[i].orderHasProductPagesCount}',
                ),
                Wrow(
                  lable: "الشكاير المتبقية",
                  val: '${widget.transquery[i].orderHasProductDeptCount}',
                ),
                Text(
                  '__________________',
                  style: TextStyle(
                      color: Colors.orange[900],
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class Wrow extends StatefulWidget {
  String lable;
  String val;
  Wrow({this.lable, this.val});

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
        Container(
          width: 120,
          // padding: EdgeInsets.only(left: 0),
          //color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.val}',
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: 0,
        ),
        Container(
          width: 160,
          // padding: EdgeInsets.only(left: 30),
          // color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.lable}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'beIN',
            ),
            //textDirection: material.TextDirection.ltr,
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
