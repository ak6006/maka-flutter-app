import 'dart:convert';

List<TransQuery> transQueryFromJson(String str) =>
    List<TransQuery>.from(json.decode(str).map((x) => TransQuery.fromJson(x)));

String transQueryToJson(List<TransQuery> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransQuery {
  TransQuery({
    this.orderId,
    this.transVehcileDriverName,
    this.firstName,
    this.date,
    this.productName,
    this.orderHasProductPagesCount,
    this.orderHasProductDeptCount,
    this.weightWeightId,
    this.productProductId,
    this.weightNet,
  });

  int orderId;
  String transVehcileDriverName;
  String firstName;
  DateTime date;
  String productName;
  int orderHasProductPagesCount;
  int orderHasProductDeptCount;
  int weightWeightId;
  int productProductId;
  int weightNet;

  factory TransQuery.fromJson(Map<String, dynamic> json) => TransQuery(
        orderId: json["order_id"] == null ? null : json["order_id"],
        transVehcileDriverName: json["transVehcile_driver_name"] == null
            ? null
            : json["transVehcile_driver_name"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        productName: json["productName"] == null ? null : json["productName"],
        orderHasProductPagesCount: json["order_has_product_Pages_Count"] == null
            ? null
            : json["order_has_product_Pages_Count"],
        orderHasProductDeptCount: json["order_has_product_dept_count"] == null
            ? null
            : json["order_has_product_dept_count"],
        weightWeightId:
            json["weight_weight_id"] == null ? null : json["weight_weight_id"],
        productProductId: json["product_product_id"] == null
            ? null
            : json["product_product_id"],
        weightNet: json["weight_net"] == null ? null : json["weight_net"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId == null ? null : orderId,
        "transVehcile_driver_name":
            transVehcileDriverName == null ? null : transVehcileDriverName,
        "firstName": firstName == null ? null : firstName,
        "date": date == null ? null : date.toIso8601String(),
        "productName": productName == null ? null : productName,
        "order_has_product_Pages_Count": orderHasProductPagesCount == null
            ? null
            : orderHasProductPagesCount,
        "order_has_product_dept_count":
            orderHasProductDeptCount == null ? null : orderHasProductDeptCount,
        "weight_weight_id": weightWeightId == null ? null : weightWeightId,
        "product_product_id":
            productProductId == null ? null : productProductId,
        "weight_net": weightNet == null ? null : weightNet,
      };
}
