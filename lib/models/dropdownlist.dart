import 'dart:convert';

DropDownList dropDownListFromJson(String str) =>
    DropDownList.fromJson(json.decode(str));

String dropDownListToJson(DropDownList data) => json.encode(data.toJson());

class DropDownList {
  DropDownList({
    this.gifts,
    this.customerOrders,
    this.custName,
    this.prodNames,
    this.storeNames,
    this.weightNames,
    this.measureNames,
    this.vehiclesData,
  });

  List<Gift> gifts;
  List<CustomerOrder> customerOrders;
  CustName custName;
  List<ProdName> prodNames;
  List<StoreName> storeNames;
  List<WeightName> weightNames;
  List<MeasureName> measureNames;
  List<VehiclesDatum> vehiclesData;

  factory DropDownList.fromJson(Map<String, dynamic> json) => DropDownList(
        gifts: json["gifts"] == null
            ? null
            : List<Gift>.from(json["gifts"].map((x) => Gift.fromJson(x))),
        customerOrders: json["customerOrders"] == null
            ? null
            : List<CustomerOrder>.from(
                json["customerOrders"].map((x) => CustomerOrder.fromJson(x))),
        custName: json["CustName"] == null
            ? null
            : CustName.fromJson(json["CustName"]),
        prodNames: json["ProdNames"] == null
            ? null
            : List<ProdName>.from(
                json["ProdNames"].map((x) => ProdName.fromJson(x))),
        storeNames: json["storeNames"] == null
            ? null
            : List<StoreName>.from(
                json["storeNames"].map((x) => StoreName.fromJson(x))),
        weightNames: json["weightNames"] == null
            ? null
            : List<WeightName>.from(
                json["weightNames"].map((x) => WeightName.fromJson(x))),
        measureNames: json["measureNames"] == null
            ? null
            : List<MeasureName>.from(
                json["measureNames"].map((x) => MeasureName.fromJson(x))),
        vehiclesData: json["vehiclesData"] == null
            ? null
            : List<VehiclesDatum>.from(
                json["vehiclesData"].map((x) => VehiclesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gifts": gifts == null
            ? null
            : List<dynamic>.from(gifts.map((x) => x.toJson())),
        "customerOrders": customerOrders == null
            ? null
            : List<dynamic>.from(customerOrders.map((x) => x.toJson())),
        "CustName": custName == null ? null : custName.toJson(),
        "ProdNames": prodNames == null
            ? null
            : List<dynamic>.from(prodNames.map((x) => x.toJson())),
        "storeNames": storeNames == null
            ? null
            : List<dynamic>.from(storeNames.map((x) => x.toJson())),
        "weightNames": weightNames == null
            ? null
            : List<dynamic>.from(weightNames.map((x) => x.toJson())),
        "measureNames": measureNames == null
            ? null
            : List<dynamic>.from(measureNames.map((x) => x.toJson())),
        "vehiclesData": vehiclesData == null
            ? null
            : List<dynamic>.from(vehiclesData.map((x) => x.toJson())),
      };
}

class CustName {
  CustName({
    this.custName,
  });

  String custName;

  factory CustName.fromJson(Map<String, dynamic> json) => CustName(
        custName: json["custName"] == null ? "ليس وكيل" : json["custName"],
      );

  Map<String, dynamic> toJson() => {
        "custName": custName == null ? "ليس وكيل" : custName,
      };
}

class CustomerOrder {
  CustomerOrder({
    this.orderId,
    this.orderHasProductId,
    this.orderDate,
    this.productId,
    this.productName,
    this.wieghtId,
    this.wieghtName,
    this.measureId,
    this.measureName,
    this.quantity,
    this.orderCars,
  });

  int orderId;
  int orderHasProductId;
  DateTime orderDate;
  int productId;
  String productName;
  int wieghtId;
  int wieghtName;
  int measureId;
  String measureName;
  double quantity;
  List<OrderCar> orderCars;

  factory CustomerOrder.fromJson(Map<String, dynamic> json) => CustomerOrder(
        orderId: json["OrderId"] == null ? null : json["OrderId"],
        orderHasProductId: json["OrderHasProductId"] == null
            ? null
            : json["OrderHasProductId"],
        orderDate: json["OrderDate"] == null
            ? null
            : DateTime.parse(json["OrderDate"]),
        productId: json["ProductId"] == null ? null : json["ProductId"],
        productName: json["ProductName"] == null ? null : json["ProductName"],
        wieghtId: json["WieghtId"] == null ? null : json["WieghtId"],
        wieghtName: json["WieghtName"] == null ? null : json["WieghtName"],
        measureId: json["MeasureId"] == null ? null : json["MeasureId"],
        measureName: json["MeasureName"] == null ? null : json["MeasureName"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        orderCars: json["orderCars"] == null
            ? null
            : List<OrderCar>.from(
                json["orderCars"].map((x) => OrderCar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId == null ? null : orderId,
        "OrderHasProductId":
            orderHasProductId == null ? null : orderHasProductId,
        "OrderDate": orderDate == null ? null : orderDate.toIso8601String(),
        "ProductId": productId == null ? null : productId,
        "ProductName": productName == null ? null : productName,
        "WieghtId": wieghtId == null ? null : wieghtId,
        "WieghtName": wieghtName == null ? null : wieghtName,
        "MeasureId": measureId == null ? null : measureId,
        "MeasureName": measureName == null ? null : measureName,
        "quantity": quantity == null ? null : quantity,
        "orderCars": orderCars == null
            ? null
            : List<dynamic>.from(orderCars.map((x) => x.toJson())),
      };
}

class OrderCar {
  OrderCar({
    this.vId,
    this.driverName,
  });

  int vId;
  String driverName;

  factory OrderCar.fromJson(Map<String, dynamic> json) => OrderCar(
        vId: json["VId"] == null ? null : json["VId"],
        driverName: json["DriverName"] == null ? null : json["DriverName"],
      );

  Map<String, dynamic> toJson() => {
        "VId": vId == null ? null : vId,
        "DriverName": driverName == null ? null : driverName,
      };
}

class Gift {
  Gift({
    this.giftid,
    this.giftname,
    this.giftBagsCount,
    this.giftimg,
  });

  int giftid;
  String giftname;
  int giftBagsCount;
  String giftimg;

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        giftid: json["giftid"] == null ? null : json["giftid"],
        giftname: json["giftname"] == null ? null : json["giftname"],
        giftBagsCount:
            json["giftBagsCount"] == null ? null : json["giftBagsCount"],
        giftimg: json["giftimg"] == null ? null : json["giftimg"],
      );

  Map<String, dynamic> toJson() => {
        "giftid": giftid == null ? null : giftid,
        "giftname": giftname == null ? null : giftname,
        "giftBagsCount": giftBagsCount == null ? null : giftBagsCount,
        "giftimg": giftimg == null ? null : giftimg,
      };
}

class MeasureName {
  MeasureName({
    this.measureId,
    this.measureName,
  });

  int measureId;
  String measureName;

  factory MeasureName.fromJson(Map<String, dynamic> json) => MeasureName(
        measureId: json["MeasureId"] == null ? null : json["MeasureId"],
        measureName: json["measureName"] == null ? null : json["measureName"],
      );

  Map<String, dynamic> toJson() => {
        "MeasureId": measureId == null ? null : measureId,
        "measureName": measureName == null ? null : measureName,
      };
}

class ProdName {
  ProdName({
    this.productId,
    this.productName,
    this.price,
    this.priceUpdateTime,
  });

  int productId;
  String productName;
  double price;
  DateTime priceUpdateTime;

  factory ProdName.fromJson(Map<String, dynamic> json) => ProdName(
        productId: json["ProductId"] == null ? null : json["ProductId"],
        productName: json["productName"] == null ? null : json["productName"],
        price: json["Price"] == null ? 0 : json["Price"].toDouble(),
        priceUpdateTime: json["PriceUpdateTime"] == null
            ? null
            : DateTime.parse(json["PriceUpdateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "ProductId": productId == null ? null : productId,
        "productName": productName == null ? null : productName,
        "Price": price == null ? null : price,
        "PriceUpdateTime":
            priceUpdateTime == null ? null : priceUpdateTime.toIso8601String(),
      };
}

class StoreName {
  StoreName({
    this.storeId,
    this.storeName,
  });

  int storeId;
  String storeName;

  factory StoreName.fromJson(Map<String, dynamic> json) => StoreName(
        storeId: json["StoreId"] == null ? null : json["StoreId"],
        storeName: json["storeName"] == null ? null : json["storeName"],
      );

  Map<String, dynamic> toJson() => {
        "StoreId": storeId == null ? null : storeId,
        "storeName": storeName == null ? null : storeName,
      };
}

class VehiclesDatum {
  VehiclesDatum({
    this.vehicleId,
    this.driverName,
    this.number,
    this.serial,
    this.model,
    this.phone,
  });

  int vehicleId;
  String driverName;
  String number;
  String serial;
  String model;
  String phone;

  factory VehiclesDatum.fromJson(Map<String, dynamic> json) => VehiclesDatum(
        vehicleId: json["VehicleId"] == null ? null : json["VehicleId"],
        driverName: json["DriverName"] == null ? null : json["DriverName"],
        number: json["Number"] == null ? null : json["Number"],
        serial: json["Serial"] == null ? null : json["Serial"],
        model: json["Model"] == null ? null : json["Model"],
        phone: json["Phone"] == null ? null : json["Phone"],
      );

  Map<String, dynamic> toJson() => {
        "VehicleId": vehicleId == null ? null : vehicleId,
        "DriverName": driverName == null ? null : driverName,
        "Number": number == null ? null : number,
        "Serial": serial == null ? null : serial,
        "Model": model == null ? null : model,
        "Phone": phone == null ? null : phone,
      };
}

class WeightName {
  WeightName({
    this.weightId,
    this.weightName,
  });

  int weightId;
  int weightName;

  factory WeightName.fromJson(Map<String, dynamic> json) => WeightName(
        weightId: json["WeightId"] == null ? null : json["WeightId"],
        weightName: json["weightName"] == null ? null : json["weightName"],
      );

  Map<String, dynamic> toJson() => {
        "WeightId": weightId == null ? null : weightId,
        "weightName": weightName == null ? null : weightName,
      };
}
