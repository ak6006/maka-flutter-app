import 'package:flutter/material.dart';
import 'package:maka/details/products.dart';
import 'package:maka/screen/addOrderItems.dart';
import 'package:maka/utils/constant.dart';
//import 'package:googleproductsapp/models/product.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({Key key, @required this.product, this.orderproductItems})
      : super(key: key);

  final Product product;
  final DropDownItem orderproductItems;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        product.buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'beIN',
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddOrderItemsScreen(
                    orderproductItems: orderproductItems,
                  )), //FilterScreenPage()),
        );
      },
      color: Colors.deepOrange, //Color(0xFF0000FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
