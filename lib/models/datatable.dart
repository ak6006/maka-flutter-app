import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maka/screen/updateOrder.dart';
import 'package:maka/utils/constant.dart';

class TableData extends DataTableSource {
  // extends DataTableSource
  dynamic pr;
//  final FirebaseDatabase database = FirebaseDatabase.instance;
  final String uid;
  int indextoedit;
//  List<Payment> list_payment;
  // final Drop_down_menu_item userInHome;

  TableData({
    this.uid,
    this.context,
    this.indextoedit,
    this.pr,
  });

  BuildContext context; // payment_queu;
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          IconButton(
            color: Colors.white,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateOrderItemsScreen(
                          updateorders: orders[index],
                        )),
              );
              print(orders[index].orderDate);
            },
          ),
        ),
        DataCell(
            Text(
                orders[index].orderDate != null
                    ? DateFormat("dd / MM / yyyy", 'ar')
                        .format(orders[index].orderDate)
                    : "NULL STR",
                style: kColumnLabelStyle), onTap: () {
          indextoedit = index;
          // showEditPaymentDialog(context);
//          print(index);
        }),
        DataCell(
          Text(
              orders[index].quantity != null
                  ? orders[index].quantity.toString()
                  : "NULL STR",
              style: kColumnLabelStyle),
          onTap: () {
            indextoedit = index;
            // showEditPaymentDialog(context);
//            print(index);
          },
        ),
        DataCell(
          Text(
              orders[index].wieghtName != null
                  ? orders[index].wieghtName.toString()
                  : "NULL STR",
              style: kColumnLabelStyle),
          onTap: () {
            indextoedit = index;
            // showEditPaymentDialog(context);
//            print(index);
          },
        ),
        DataCell(
          Text(
              orders[index].measureName != null
                  ? orders[index].measureName.toString()
                  : "NULL STR",
              style: kColumnLabelStyle),
          onTap: () {
            indextoedit = index;
            // showEditPaymentDialog(context);
//            print(index);
          },
        ),
        DataCell(
          Text(
              orders[index].productName != null
                  ? orders[index].productName.toString()
                  : "NULL STR",
              style: kColumnLabelStyle),
          onTap: () {
            indextoedit = index;
            //  showEditPaymentDialog(context);
//            print(index);
          },
        ),
      ],
    );
//    DataRow.byIndex(index: index,cells: index[]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => 0;
}
