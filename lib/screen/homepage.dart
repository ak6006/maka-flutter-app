import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:maka/screen/qrcode.dart';

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String _scanBarcode = 'Unknown';

  Future<String> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;
    // _scanBarcode = barcodeScanRes;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
    return barcodeScanRes;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 51, 94, 1),
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding:EdgeInsets.only(top:size.height*0.2),
            ),
            Container(
              // color: Color.fromRGBO(0, 51, 94, 1),
              // decoration: new BoxDecoration(
              //   borderRadius: new BorderRadius.circular(16.0),
              //   color: Colors.green,
              // ),
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: size.height*0.15,
                  child: Center(
                    child: Image(
                      height: size.height*0.2,
                      image: AssetImage('assets/images/lg2.jpg'),
                    ),
                  ),
                ),
              ),
            ),

            new Padding(
              padding:EdgeInsets.only(top: size.height*0.08),
            ),
            Container(
              height: size.height*0.07,
              width: size.width*0.4,
              child: new FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                color: Color.fromRGBO(0, 157, 68, 1),
                child: new Text(
                  'تسجيل الدخول',
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'beIN',
                  ),
                ),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: size.height*0.05),
            ),
            Container(
              height: size.height*0.07,
              width: size.width*0.4,
              child: new FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                color: Color.fromRGBO(174, 0, 145, 1),
                child: new Text(
                  'تسجيل حساب جديد',
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'beIN',
                  ),
                ),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: size.height*0.06),
            ),
            Container(
              height: size.height*0.07,
              width: size.width*0.4,
              child: new FlatButton(
                onPressed: () async {
                  var ss = await scanQR();
                  // print('ddddddddddddd $ss');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QrCode(
                              qr: ss,
                            )),
                  );
                },
                color: Color.fromRGBO(179, 0, 34, 1),
                child: new Text(
                  'QR Code',
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'beIN',
                  ),
                ),
              ),
            ),

            // Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
