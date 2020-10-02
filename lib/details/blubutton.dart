import 'package:flutter/material.dart';
import 'package:maka/details/products.dart';
//import 'package:googleproductsapp/models/product.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        product.buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: 'beIN',
        ),
      ),
      onPressed: () {},
      color: Colors.deepOrange, //Color(0xFF0000FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
