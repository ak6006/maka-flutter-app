import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:maka/bloca/dataprovider.dart';
import 'package:maka/bloca/dataMbloc.dart';
import 'package:maka/models/dropdownlist.dart';
import 'package:maka/utils/databasehelper.dart';
import 'dart:ui';

AsyncSnapshot snapshotdata;

DataBloc blocData;
bool datastate = false;
BuildContext currentcontext;
DataProvider dataProvider = DataProvider();
//StreamSubscription<ApiResponse<DropDownList>> streamSubscription;
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

// List<String> gifttitles =
//     []; //= []; //dropDownList.gifts.map((e) => e.giftname);
// List<Widget> giftimages = [];
// List<Uint8List> giftimagesdata = [];
List<GiftRoot> giftroot = [];

Future inislizedata(DropDownList data) async {
  // var res = await databaseHelper.getProductData();
  // if (res == null) return;
  // dropDownList = dropDownListFromJson(res);
  dropDownList = data;

  productItems.clear();
  // gifttitles.clear();
  // giftimages.clear();
  // giftimagesdata.clear();
  giftroot.clear();
  measureItems.clear();
  weghtItems.clear();
  storeItems.clear();
  orders.clear();
  vanDriver.clear();

  agentCustomerName = dropDownList.custName.custName;
  for (var h in dropDownList.prodNames) {
    if (h.productName != 'كل المنتجات') {
      productItems.add(DropDownItem(
          id: h.productId == 0 ? 0 : h.productId,
          name: h.productName,
          price: h.price,
          priceUpdateTime: h.priceUpdateTime));
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

  for (var h in dropDownList.gifts) {
    Uint8List image = Base64Codec().decode(h.giftimg);
    giftroot.add(
      GiftRoot(
        giftid: h.giftid,
        giftname: h.giftname,
        giftBagsCount: h.giftBagsCount,
        giftimg: image,
        imageHero: Hero(
          tag: h.giftname,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: new Image.memory(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    //------------------------------------
    // giftimagesdata.add(image);
    // giftimages.add(
    //   Hero(
    //     tag: h.giftname,
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(20.0),
    //       child: new Image.memory(
    //         image,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    // );
    // gifttitles.add(h.giftname);
  }

  // var b = giftroot.map((e) => e.giftname).toList();
  // print(b);
}

class DropDownItem {
  int id;
  String name;
  bool state;
  double price;
  DateTime priceUpdateTime;

  DropDownItem(
      {this.id, this.name, this.state, this.price, this.priceUpdateTime});
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

//========================================
//======================================

enum Role { TANKER, FIGHTER, MARKSMAN, MAGE, ASSASIN }
enum Difficulty {
  LOW,
  MODERATE,
  HIGH,
}

final backgoundColor = Color(0xff000913);
final appbarColor = Color(0xff112120);

final difficultyEnableColor = Color(0xff08d6f6);
final difficultyDisableColor = Color(0xff023240);

const textTheme = TextTheme(
  headline1: TextStyle(
      fontSize: 60.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontStyle: FontStyle.italic,
      letterSpacing: 4.0),
  headline2: TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
      letterSpacing: 1.0),
  headline3: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
      letterSpacing: 1.0),
  bodyText1: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
      letterSpacing: 1.0),
);

class GiftRoot {
  GiftRoot({
    this.giftid,
    this.giftname,
    this.giftBagsCount,
    this.giftimg,
    this.imageHero,
  });

  int giftid;
  String giftname;
  int giftBagsCount;
  Uint8List giftimg;
  Widget imageHero;
}
