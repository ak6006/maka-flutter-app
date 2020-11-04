import 'dart:convert';

List<CustomerTransQuery> customerTransQueryFromJson(String str) =>
    List<CustomerTransQuery>.from(
        json.decode(str).map((x) => CustomerTransQuery.fromJson(x)));

String customerTransQueryToJson(List<CustomerTransQuery> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerTransQuery {
  CustomerTransQuery({
    this.orderId,
    this.date,
    this.transVehcileDriverName,
    this.transVehcileNum,
    this.productName,
    this.quantity,
    this.measreName,
    this.orderHasProductState,
    this.orderHasProductInDate,
    this.orderHasProductOutDate,
  });

  int orderId;
  DateTime date;
  String transVehcileDriverName;
  String transVehcileNum;
  String productName;
  double quantity;
  String measreName;
  int orderHasProductState;
  DateTime orderHasProductInDate;
  DateTime orderHasProductOutDate;

  factory CustomerTransQuery.fromJson(Map<String, dynamic> json) =>
      CustomerTransQuery(
        orderId: json["order_id"] == null ? null : json["order_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        transVehcileDriverName: json["transVehcile_driver_name"] == null
            ? null
            : json["transVehcile_driver_name"],
        transVehcileNum:
            json["transVehcile_num"] == null ? null : json["transVehcile_num"],
        productName: json["productName"] == null ? null : json["productName"],
        quantity: json["Quantity"] == null
            ? null
            : double.parse(json["Quantity"].toString()),
        measreName: json["measre_name"] == null ? null : json["measre_name"],
        orderHasProductState: json["order_has_product_state"] == null
            ? null
            : json["order_has_product_state"],
        orderHasProductInDate: json["order_has_product_in_date"] == null
            ? null
            : DateTime.parse(json["order_has_product_in_date"]),
        orderHasProductOutDate: json["order_has_product_out_date"] == null
            ? null
            : DateTime.parse(json["order_has_product_out_date"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId == null ? null : orderId,
        "date": date == null ? null : date.toIso8601String(),
        "transVehcile_driver_name":
            transVehcileDriverName == null ? null : transVehcileDriverName,
        "transVehcile_num": transVehcileNum == null ? null : transVehcileNum,
        "productName": productName == null ? null : productName,
        "Quantity": quantity == null ? null : quantity,
        "measre_name": measreName == null ? null : measreName,
        "order_has_product_state":
            orderHasProductState == null ? null : orderHasProductState,
        "order_has_product_in_date": orderHasProductInDate == null
            ? null
            : orderHasProductInDate.toIso8601String(),
        "order_has_product_out_date": orderHasProductOutDate == null
            ? null
            : orderHasProductOutDate.toIso8601String(),
      };
}
