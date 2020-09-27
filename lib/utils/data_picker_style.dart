import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataPicker extends StatefulWidget {
  DateTime dateTime;
  String lable;

  DataPicker({this.dateTime, this.lable});
  @override
  _DataPickerState createState() => _DataPickerState();
}

class _DataPickerState extends State<DataPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now().add(Duration(days: 1)),
          firstDate: DateTime.now().add(Duration(days: 1)),
          lastDate: DateTime.now().add(Duration(days: 90)),
          //  initialDate: widget.dateTime,
          // firstDate: DateTime(2020),
          // lastDate: widget.dateTime,
        ).then((data) {
          setState(() {
            widget.dateTime = data;
          });
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
            border: Border.all(
                width: MediaQuery.of(context).size.width * 0.01,
                color: Colors.orange[800]),
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
