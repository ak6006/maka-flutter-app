import 'package:flutter/material.dart';
import 'package:maka/details/blubutton.dart';
import 'package:maka/details/products.dart';
//import '../../models/product.dart';
//import 'blue_button.dart';

class RightImageProductImageWidget extends StatelessWidget {
  const RightImageProductImageWidget({
    Key key,
    @required this.screenHeight,
    @required this.product,
  }) : super(key: key);

  final double screenHeight;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32),
      height: screenHeight * 0.3,
      color: product.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                BlueButton(product: product),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 50,
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
