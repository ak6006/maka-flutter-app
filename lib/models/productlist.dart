import 'dart:convert';

List<ProductList> productListFromJson(String str) => List<ProductList>.from(
    json.decode(str).map((x) => ProductList.fromJson(x)));

String productListToJson(List<ProductList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductList {
  ProductList({
    this.productName,
    this.price,
    this.priceUpdateTime,
  });

  String productName;
  double price;
  String priceUpdateTime;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        productName: json["productName"] == null ? null : json["productName"],
        price: json["Price"] == null ? null : json["Price"],
        priceUpdateTime:
            json["PriceUpdateTime"] == null ? null : json["PriceUpdateTime"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName == null ? null : productName,
        "Price": price == null ? null : price,
        "PriceUpdateTime": priceUpdateTime == null ? null : priceUpdateTime,
      };
}
