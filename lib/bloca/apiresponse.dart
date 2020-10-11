import 'package:maka/bloca/dataprovider.dart';
import 'package:maka/models/dropdownlist.dart';
import 'package:maka/utils/constant.dart';
import 'package:provider/provider.dart';

class ApiResponse<T> {
  Status status;
//  T data;
  DropDownList data;
  String message;
  // ApiResponse({this.data, this.message, this.status});

  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) {
    setupdata();
  }
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  void setupdata() async {
    // Provider.of<DataProvider>(currentcontext).setnewstate();
    await inislizedata(this.data);
    status = Status.COMPLETED;
    dataProvider.setnewstate();
    print('hjgggggggggggg');
    print('${this.data.custName.custName}');
    print(dropDownList.gifts[0].giftname);
  }
}

enum Status { LOADING, COMPLETED, ERROR }
