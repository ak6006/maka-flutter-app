import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maka/bloca/apiresponse.dart';
import 'package:maka/gift/detail_view.dart';
import 'package:maka/gift/giftModels.dart';
import 'package:maka/gift/giftview.dart';
import 'package:maka/utils/constant.dart';

//import 'package:vertical_card_pager/vertical_card_pager.dart';

class GiftDashBoardScreen extends StatefulWidget {
  @override
  _GiftDashBoardScreenState createState() => _GiftDashBoardScreenState();
}

// [
//   "AKALI",
//   "CAMILE",
//   "EZREAL111",
//   "IRELIA",
//   "POPPY",
//   "ZOE",
// ];

class _GiftDashBoardScreenState extends State<GiftDashBoardScreen> {
  // List<String> gifttitles =
  //     []; //= []; //dropDownList.gifts.map((e) => e.giftname);
  // List<Widget> giftimages = [];

  // @override
  void initState() {
    super.initState();

    // giftimages.add(
    //   Hero(
    //     tag: "Iphone 11",
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(20.0),
    //       child:
    //           // new Image.memory(
    //           //   image,
    //           //   fit: BoxFit.cover,
    //           // ),
    //           Image.asset(
    //         "assets/images/a1.png",
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    // );
    // gifttitles.add("Iphone 11");
    // giftimages.add(
    //   Hero(
    //     tag: "Iphone 11",
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(20.0),
    //       child:
    //           // new Image.memory(
    //           //   image,
    //           //   fit: BoxFit.cover,
    //           // ),
    //           Image.asset(
    //         "assets/images/a2.png",
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   ),
    // );
    // gifttitles.add("Iphone 11");

    // dropDownList.gifts.map((e) {
    //   return Hero(
    //     tag: "AKALI",
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(20.0),
    //       child: Image.asset(
    //         "images/akali_lol.gif",
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //   );
    // });
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (snapshotdata.hasData) {
      switch (snapshotdata.data.status) {
        case Status.LOADING:
          return Container(
            height: 60,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
          break;
        case Status.COMPLETED:
          return buildGiftWidget(size, context);
          break;
        case Status.ERROR:
          return Container(
            child: Text(
              'لا يوجد اتصال بالسرفر',
              style: TextStyle(color: Colors.red),
            ),
          );
          break;
      }
    }
    return Container();
    // return Scaffold(
    //   body: snapshotdata.data.status != Status.COMPLETED
    //       ? Container(
    //           child: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         )
    //       : buildGiftWidget(size, context),
    // );
  }

  SafeArea buildGiftWidget(Size size, BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(254, 88, 0, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              // color: Color.fromRGBO(254, 88, 0, 1),
              height: 50, //size.height * 0.07,
              width: 220, //size.width * 0.7,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Image(
                    height: size.height * 0.07,
                    image: AssetImage('assets/images/gift.png'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    // height: size.height * 0.07,
                    // width: size.width * 0.4,
                    child: new Text(
                      'جوائز مكه هاي فيد',
                      style: new TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'beIN',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: GivtView(
                  // textStyle: TextStyle(color : Colors.red),
                  titles: giftroot.map((e) => e.giftname).toList(),
                  images: giftroot.map((e) => e.imageHero).toList(),
                  onPageChanged: (page) {
                    // print(page);
                  },
                  onSelectedItem: (index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailView(
                                champion: Champion(
                                    name: giftroot[index].giftname,
                                    image: giftroot[index].giftimg,
                                    role: Role.ASSASIN,
                                    difficulty: Difficulty.MODERATE,
                                    nickName: 'جائزة تستحق التجربة',
                                    count: (index * 8).toString(),
                                    description:
                                        "تقدم هذه الجائزة كهدية من مكة هاي فيد عند شراء كمية معينة من العلف"),
                              )),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
