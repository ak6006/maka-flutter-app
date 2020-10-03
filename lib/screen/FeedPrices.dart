import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:maka/models/dropdownlist.dart';
import 'package:maka/screen/dashboard.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:maka/models/productlist.dart';
class FeedPrices extends StatefulWidget {
  FeedPrices({productsInfo});
  @override
  _FeedPricesState createState() => _FeedPricesState();
}

class _FeedPricesState extends State<FeedPrices> {
  ProdName productsInfo;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  bool isLoading = true;
  var list;
  getPrices() async {
    dynamic result = await databaseHelper.getProductData();
    print(result);
    productsInfo = ProdName.fromJson(result);
    print(productsInfo);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPrices();
    print('aaaaaaaaaaaaaaaammmmmmmmmmmmmmmmmm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'اسعار اعلاف اليوم',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'beIN',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              if (isLoading)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                buildExpanded(productsInfo.productId),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.6),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoardPage()),
                    );
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
    );
  }

  Expanded buildExpanded(int index) {
    ListView.builder(
      itemCount: index,
      itemBuilder: (context, i) {
        return Column(
          //scrollDirection: Axis.vertical,
          children: <Widget>[
        Wrow(
           lable: "رقم المنتج",
           integerVals: productsInfo.productId,
        ),
        Wrow(
        lable: "اسم المنتج",
        val: productsInfo.productName),
        // Wrow(
        //   lable: "التاريخ",
        //   val: '',
        // ),
//-------
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
    );
  }
}

class Wrow extends StatefulWidget {
  String lable;
  String val;
  int integerVals;
  double doubleVals;
  material.TextDirection direction;
  Wrow(
      {this.lable,
        this.val,
        this.integerVals,
        this.doubleVals,
        this.direction = material.TextDirection.ltr});
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
        Expanded(
            child: Container(
              // padding: EdgeInsets.only(left: 0),
              //color: const Color.fromRGBO(0, 51, 94, 1),
              child: Text(
                '${widget.integerVals}',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.right,
              ),
            )),
        Expanded(
            child: Container(
              // padding: EdgeInsets.only(left: 0),
              //color: const Color.fromRGBO(0, 51, 94, 1),
              child: Text(
                '${widget.doubleVals}',
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
