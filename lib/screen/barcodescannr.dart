import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:maka/models/querybarcode.dart';
import 'package:flutter/material.dart' as material;

class BarCodePage extends StatefulWidget {
  QueryBarCode queryBarCode;
  BarCodePage({this.queryBarCode});
  @override
  _BarCodePageState createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
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
                    'بيانات رمز الاستجابة',
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'beIN',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                //height: 90.0,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Wrow(
                      lable: "السريال",
                      val: '${widget.queryBarCode.barcodeSerialNumber}',
                    ),
                    Wrow(
                      lable: "تاريخ الانتاج",
                      val: DateFormat("dd / MM / yyyy", 'ar')
                          .format(widget.queryBarCode.storeHasProductDate),
                    ),
                    Wrow(
                      lable: "نوع المنتج",
                      val: widget.queryBarCode.productName,
                    ),
                    Wrow(
                      lable: "الوزن",
                      val: '${widget.queryBarCode.weightNet}',
                    ),
                    Wrow(
                      lable: "تاريخ البيع",
                      val: DateFormat("dd / MM / yyyy", 'ar')
                          .format(widget.queryBarCode.date),
                    ),
                    Wrow(
                      lable: "اسم الوكيل",
                      val: '${widget.queryBarCode.customerName}',
                    ),
                    Wrow(
                      lable: "رقم عربية النقل",
                      val: '${widget.queryBarCode.transVehcileNum}',
                    ),
                    Wrow(
                      lable: "اسم السائق",
                      val: '${widget.queryBarCode.transVehcileDriverName}',
                    ),
                    Wrow(
                      lable: "الوردية",
                      val: '${widget.queryBarCode.shiftName}',
                    ),
                    Wrow(
                      lable: "مدير الوردية",
                      val: '${widget.queryBarCode.shiftAdminName}',
                    ),
                    Wrow(
                      lable: "كمية الطلبية",
                      val:
                          '${widget.queryBarCode.quantity} : ${widget.queryBarCode.measreName}',
                    ),
                  ],
                ),
              ),
            ),
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
        Container(
          width: 120,
          // padding: EdgeInsets.only(left: 0),
          //color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.val}',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Container(
          width: 140,
          // padding: EdgeInsets.only(left: 30),
          // color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text(
            '${widget.lable}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
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
