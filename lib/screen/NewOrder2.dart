import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maka/screen/dashboard.dart';
import 'package:maka/utils/constant.dart';
import 'package:maka/utils/primary_text_field.dart';

import 'customertransquery.dart';
import 'newOrder.dart';

class NewOrder2 extends StatefulWidget {
  @override
  _NewOrder2State createState() => _NewOrder2State();
}

class _NewOrder2State extends State<NewOrder2> {
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];
  final TextEditingController _quantityTonsController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        // child: Theme(
        //   data: Theme.of(context).copyWith(dividerColor: Colors.deepOrange),
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
                padding: new EdgeInsets.only(top: 10.0),
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
                  Column(
                    children: [
                      Container(
                        // padding: const EdgeInsets.only(left: 30),
                        margin: new EdgeInsets.only(top: size.height * 0.04),
                        width: 190,
                        alignment: Alignment.center,
                        color: Color.fromRGBO(254, 88, 0, 1),
                        child: new Text(
                          'اضافة طلبية جديدة',
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'beIN',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      CustomerNameRow(
                        lable: '  اهلا',
                        val: agentCustomerName,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  carouselSlider = CarouselSlider(
                    options: CarouselOptions(
                      height: 150,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      reverse: false,
                      enableInfiniteScroll: true,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(milliseconds: 4000),
                      //pauseAutoPlayOnTouch: Duration(seconds: 10),
                      scrollDirection: Axis.horizontal,
                      // onPageChanged: (index) {
                      //   setState(() {
                      //     _current = index;
                      //   });
                      // },
                    ),
                    items: imgList.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imgUrl,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                strokeWidth: 1.0,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              PrimaryTextField(
                label: ' ادخل الكمية بالطن',
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'الرجاء ادخال الكمية';
                  } //else if (isValid == false) {
                  //return 'Please enter a valid email';
                  //}
                  else {
                    return null;
                  }
                },
                controller: _quantityTonsController,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.02),
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(254, 88, 0, 1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 40,
                    width: 160,
                    child: new FlatButton(
                      onPressed: () {
                        // print(productval);
                        Navigator.pop(context);
                      },
                      color: Color.fromRGBO(254, 88, 0, 1),
                      child: new Text(
                        'الغاء',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'beIN',
                        ),
                      ),
                    ),
                  ),

                  ///ends
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(254, 88, 0, 1),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    height: 40,
                    width: 160,
                    child: new FlatButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashBoardPage()),
                        );
                      },
                      color: Color.fromRGBO(254, 88, 0, 1),
                      child: new Text(
                        'تأكيد الكمية',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'beIN',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerNameRow extends StatefulWidget {
  String lable;
  String val;
  CustomerNameRow({this.lable, this.val});
  @override
  _CustomerNameRowState createState() => _CustomerNameRowState();
}

class _CustomerNameRowState extends State<CustomerNameRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${widget.val}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'beIN',
            ),
            textAlign: TextAlign.right),
        Text(
          '${widget.lable}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'beIN',
          ),
        ),
      ],
    );
  }
}
