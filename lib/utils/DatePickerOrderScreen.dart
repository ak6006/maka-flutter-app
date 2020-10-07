import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class DatePickerOrderScreen extends StatefulWidget {
  DateTime dateTime;
  String lable;

  DatePickerOrderScreen({this.dateTime, this.lable});
  @override
  _DatePickerOrderScreenState createState() => _DatePickerOrderScreenState();
}

class _DatePickerOrderScreenState extends State<DatePickerOrderScreen> {
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1)))
        //  && day.isBefore(DateTime.now().add(Duration(days: 10)))
        )) {
      return true;
    } else if (widget.dateTime == DateTime.now()) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now().add(Duration(days: 1)),
          firstDate:
              DateTime.now().add(Duration(days: 1)), //.add(Duration(days: 1)),
          lastDate: DateTime.now().add(Duration(days: 90)),
          //currentDate:,
          //initialDatePickerMode:,
          errorFormatText: 'Enter valid date',
          errorInvalidText: 'Enter date in valid range',
          selectableDayPredicate: _decideWhichDayToEnable,
        ).then((data) {
          setState(() {
            widget.dateTime = data;
          });
        });
      },
      child: Container(
        height: 56.0,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
            borderRadius: BorderRadius.circular(
              15.0,
            )),
        child: Center(
          child: ListTile(
            title: Text(
              widget.dateTime == null
                  ? new DateFormat("dd/MM/yyyy", "ar")
                      .format(widget.dateTime = DateTime.now())
                      .toString()
                  : new DateFormat("dd/MM/yyyy", "ar").format(widget.dateTime),
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            // subtitle: Text(
            //   '${widget.lable}',
            //   style: TextStyle(color: Colors.orange),
            //   textAlign: TextAlign.right,
            //   //textWidthBasis: TextWidthBasis.longestLine,
            // ),
            trailing: Column(
              children: [
                Icon(
                  Icons.date_range,
                  color: Colors.orange,
                ),
                Text(
                  '${widget.lable}',
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                  //textWidthBasis: TextWidthBasis.longestLine,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
