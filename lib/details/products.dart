import 'package:flutter/material.dart';

class Product {
  final String imagePath, name, description, buttonText, price, productInfo;
  final Color backgroundColor;

  Product(
      {this.imagePath,
      this.name,
      this.description,
      this.buttonText,
      this.backgroundColor,
      this.price,
      this.productInfo});
}

final Product pixelStand = Product(
  imagePath: "assets/images/1.png",
  name: "Pixel stand",
  description: "New Release",
  buttonText: "",
  backgroundColor: Color(0xFFF9F9F9),
);

final Product dayDreamView = Product(
  imagePath: "assets/images/2.png",
  name: "DayDream View",
  description: "Premium",
  buttonText: "",
  backgroundColor: Color(0xFFE0DDFF),
);

final Product pixel = Product(
    imagePath: "assets/images/1.png",
    name: "Pixel 3a",
    description: "Meet the Google Pixel 3a.",
    buttonText: "Learn more",
    backgroundColor: Color(0xFFF5F5F5),
    productInfo: "jukjh");

final Product stadia = Product(
    imagePath: "assets/images/1.png",
    name: "Google\nStadia",
    description: "New Release",
    buttonText: "CHECK OUT",
    backgroundColor: Color(0xFFFBE9EB),
    price: "69",
    productInfo: "Stadia is Google's new cloud based "
        "gaming platform that allows you to play your favorite git video games across screens instantly.");
