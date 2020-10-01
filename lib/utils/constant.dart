import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:maka/models/dropdownlist.dart';
import 'package:maka/utils/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

String agentCustomerName;
const kPrimaryColor = Color(0xFF1B1448);

const kColumnLabelStyle = TextStyle(
    color: Colors.white, fontFamily: 'beIN', fontWeight: FontWeight.bold);
// TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor);
DropDownList dropDownList;

List<DropDownItem> productItems = [];
List<DropDownItem> storeItems = [];
List<DropDownItem> weghtItems = [];
List<DropDownItem> measureItems = [];
List<DropDownItem> vanDriver = [];
List<CustomerOrder> orders = new List<CustomerOrder>();
DatabaseHelper databaseHelper = new DatabaseHelper();
//final prefs = SharedPreferences.getInstance();

Future inislizedata() async {
  //prefs = await SharedPreferences.getInstance();
  var res = await databaseHelper.getProductData();
  dropDownList = dropDownListFromJson(res);
  for (var h in dropDownList.prodNames) {
    print(h.productName);
  }
  productItems.clear();
  measureItems.clear();
  weghtItems.clear();
  storeItems.clear();
  orders.clear();
  vanDriver.clear();

  agentCustomerName = dropDownList.custName.custName;
  for (var h in dropDownList.prodNames) {
    if (h.productName != 'كل المنتجات') {
      productItems.add(DropDownItem(
          id: h.productId == 0 ? 0 : h.productId, name: h.productName));
    }
  }
  for (var h in dropDownList.storeNames) {
    storeItems.add(DropDownItem(id: h.storeId, name: h.storeName));
  }

  for (var h in dropDownList.measureNames) {
    measureItems.add(DropDownItem(id: h.measureId, name: h.measureName));
  }
  for (var h in dropDownList.weightNames) {
    weghtItems.add(DropDownItem(id: h.weightId, name: h.weightName.toString()));
  }
  for (var h in dropDownList.customerOrders) {
    // List<OrderCar> listofcars = h.orderCars;
    orders.add(CustomerOrder(
        orderId: h.orderId,
        orderHasProductId: h.orderHasProductId,
        orderDate: h.orderDate,
        productId: h.productId,
        productName: h.productName,
        wieghtId: h.wieghtId,
        wieghtName: h.wieghtName,
        measureId: h.measureId,
        measureName: h.measureName,
        quantity: h.quantity,
        orderCars: h.orderCars));
  }
  for (var h in dropDownList.vehiclesData) {
    vanDriver
        .add(DropDownItem(id: h.vehicleId, name: h.driverName, state: false));
  }

  for (var h in orders) {
    print(h.orderId);
    for (var d in h.orderCars) {
      print(d.driverName);
    }
  }
}

class DropDownItem {
  int id;
  String name;
  bool state;
  DropDownItem({this.id, this.name, this.state});
}

alertDialog(DialogType type, context, String titel, String desc, IconData icon,
    Color color) {
  return AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: false,
      title: titel,
      desc: desc,
      btnOkOnPress: () {},
      btnOkIcon: icon,
      btnOkColor: color)
    ..show();
}

// class Orders {
//   Orders({
//     this.orderId,
//     this.orderHasProductId,
//     this.orderDate,
//     this.productId,
//     this.productName,
//     this.wieghtId,
//     this.wieghtName,
//     this.measureId,
//     this.measureName,
//     this.quantity,
//     this.orderCars,
//   });

//   int orderId;
//   int orderHasProductId;
//   DateTime orderDate;
//   int productId;
//   String productName;
//   int wieghtId;
//   int wieghtName;
//   int measureId;
//   String measureName;
//   String quantity;
//   List<OrderCar> orderCars;
// }

// class OrderCarList {
//   OrderCarList({
//     this.vId,
//     this.driverName,
//   });

//   int vId;
//   String driverName;
// }
