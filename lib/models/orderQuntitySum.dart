import 'dart:convert';

List<OrderQuantitySumQuery> orderQuantitySumQueryFromJson(String str) =>
    List<OrderQuantitySumQuery>.from(
        json.decode(str).map((x) => OrderQuantitySumQuery.fromJson(x)));

String orderQuantitySumQueryToJson(List<OrderQuantitySumQuery> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderQuantitySumQuery {
  OrderQuantitySumQuery({
    this.productName,
    this.measreName,
    this.sumQuantity,
  });

  String productName;
  String measreName;
  double sumQuantity;

  factory OrderQuantitySumQuery.fromJson(Map<String, dynamic> json) =>
      OrderQuantitySumQuery(
        productName: json["productName"] == null ? null : json["productName"],
        measreName: json["measre_name"] == null ? null : json["measre_name"],
        sumQuantity: json["sumQuantity"] == null
            ? null
            : double.parse(json["sumQuantity"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "productName": productName == null ? null : productName,
        "measre_name": measreName == null ? null : measreName,
        "sumQuantity": sumQuantity == null ? null : sumQuantity,
      };
}
