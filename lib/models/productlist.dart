import 'dart:convert';

List<ProductList> productListFromJson(String str) => List<ProductList>.from(
    json.decode(str).map((x) => ProductList.fromJson(x)));

String productListToJson(List<ProductList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductList {
  ProductList({
    this.productName,
  });

  String productName;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        productName: json["productName"] == null ? null : json["productName"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName == null ? null : productName,
      };
}
