import 'package:maka/models/dropdownlist.dart';
import 'package:maka/utils/constant.dart';

class CallApiResponse<T> {
  Status status;
//  T data;
  T data;
  String message;
  // CallApiResponse({this.data, this.message, this.status});

  CallApiResponse.loading(this.message) : status = Status.LOADING;
  CallApiResponse.completed(this.data) : status = Status.COMPLETED;
  CallApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  // void setupdata() async {
  //   await inislizedata(this.data);
  //   status = Status.COMPLETED;

  //   print('hjgggggggggggg');
  //   print('${this.data.custName.custName}');
  //   print(dropDownList.gifts[0].giftname);
  // }
}

enum Status { LOADING, COMPLETED, ERROR }
