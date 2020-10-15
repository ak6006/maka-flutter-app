<<<<<<< HEAD
import 'dart:math';

=======
>>>>>>> f1b41dfb01906add7f94ad088b788b338b054fae
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
      padding: const EdgeInsets.only(left: 32),
      height: screenHeight * 0.3,
      // color: product.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  //  color: Colors.blue[400],
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                      fontFamily: 'beIN',
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14.0,
                    fontFamily: 'beIN',
                  ),
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
          Expanded(
            flex: 5,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 30,
                  bottom: -50,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Image.asset(product.imagePath),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
