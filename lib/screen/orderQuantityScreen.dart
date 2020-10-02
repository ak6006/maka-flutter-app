import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:maka/models/customertransquery.dart';
import 'package:maka/models/orderQuntitySum.dart';

// ignore: must_be_immutable
class OrderQuantityScreen extends StatefulWidget {
  //List<CustomerTransQuery> customertransquery;
  List<OrderQuantitySumQuery> orderquantitysumquery;
  OrderQuantityScreen({this.orderquantitysumquery});

  @override
  _OrderQuantityScreenState createState() => _OrderQuantityScreenState();
}

class _OrderQuantityScreenState extends State<OrderQuantityScreen> {
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
                    'بيانات مشتريات وكيل',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            buildExpanded(widget.orderquantitysumquery.length),
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
        //height: 90.0,
        child: ListView.builder(
          itemCount: index,
          itemBuilder: (context, i) {
            return Column(
              //scrollDirection: Axis.vertical,
              children: <Widget>[
                Wrow(
                  lable: "اسم المنتج",
                  val: '${widget.orderquantitysumquery[i].productName}',
                ),
                Wrow(
                  lable: "وحده القياس",
                  val: '${widget.orderquantitysumquery[i].measreName}',
                ),
                Wrow(
                  lable: "الكمية",
                  val: widget.orderquantitysumquery[i].sumQuantity.toString(),
                ),

                // Wrow(
                //   lable: "حالة العربية",
                //   val: getstate(
                //       widget.customertransquery[i].transVehcileHasOrderState),
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
          margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
          width: 190,
          // padding: EdgeInsets.only(left: 0),
          //color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.val}',
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          width: 80,
          // padding: EdgeInsets.only(left: 30),
          // color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.lable}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'beIN',
            ),
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
          width: 90,

          padding: EdgeInsets.only(left: 30),
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
        SizedBox(
          width: 20,
        ),
        Container(
          //  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          width: 80,
          // padding: EdgeInsets.only(left: 30),
          // color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.state}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'beIN',
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: 70,
        ),
        Container(
          width: 70,
          // padding: EdgeInsets.only(left: 30),
          // color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.lable}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'beIN',
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: 0,
        ),
      ],
    );
  }
}
