import 'package:flutter/foundation.dart';

class DataProvider extends ChangeNotifier {
  bool state = false;
  String gas = 'asdfgh';

  void setnewstate() {
    state = true;
    gas = 'banana';
    print('dddddddddddddddddd');
    notifyListeners();
  }
}
