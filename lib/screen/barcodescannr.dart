import 'package:flutter/material.dart';
import 'package:maka/models/querybarcode.dart';

class BarCodePage extends StatefulWidget {
  QueryBarCode queryBarCode;
  BarCodePage({this.queryBarCode});
  @override
  _BarCodePageState createState() => _BarCodePageState();
}

class _BarCodePageState extends State<BarCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      body: Column(
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
                color: Color.fromRGBO(2, 36, 67, 1),
                child: new Text(
                  'BarCode Result',
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'beIN',
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          // Container(
          //   height: 44.0,
          //   child: ListView(
          //     scrollDirection: Axis.vertical,
          //     children: <Widget>[

          //     ],
          //   ),
          // ),
          Wrow(
            lable: "السريال",
            val: '${widget.queryBarCode.barcodeSerialNumber}',
          ),
          Wrow(
            lable: "تاريخ الانتاج",
            val: widget.queryBarCode.storeHasProductDate,
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
            val: '${widget.queryBarCode.date}',
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
            lable: "مدير الوردية",
            val: '${widget.queryBarCode.shiftName}',
          ),

          new Padding(
            padding: new EdgeInsets.only(top: 40.0),
          ),
          Container(
            height: 40,
            width: 160,
            child: new FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Color.fromRGBO(179, 0, 34, 1),
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
          width: 130,
          // padding: EdgeInsets.only(left: 0),
          color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text('${widget.val}',
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        SizedBox(
          width: 70,
        ),
        Container(
          width: 90,
          // padding: EdgeInsets.only(left: 30),
          color: const Color.fromRGBO(0, 51, 94, 1),
          child: Text('${widget.lable}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'beIN',
              )),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
