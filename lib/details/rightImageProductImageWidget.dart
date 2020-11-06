import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maka/details/blubutton.dart';
import 'package:maka/details/products.dart';
import 'package:maka/utils/constant.dart';
//import '../../models/product.dart';
//import 'blue_button.dart';

class RightImageProductImageWidget extends StatelessWidget {
  const RightImageProductImageWidget({
    Key key,
    @required this.screenHeight,
    @required this.product,
    this.orderproductItems,
  }) : super(key: key);

  final double screenHeight;
  final Product product;
  final DropDownItem orderproductItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: product.backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.only(left: 7),
      height: screenHeight * 0.2,
      // color: product.backgroundColor,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Stack(
              //   children: <Widget>[],
              // ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 30,
                      bottom: -50,
                      child: Transform.rotate(
                        angle: -0.3,
                        child: Image.asset(product.imagePath),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            // width: 180,
            //  flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 210,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  //  color: Colors.blue[400],
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14.0,
                      fontFamily: 'beIN',
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Text(
                  'سعر اليوم \n${product.description}',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                      fontFamily: 'beIN',
                      color: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                BlueButton(
                  product: product,
                  orderproductItems: orderproductItems,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
