import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final Function onChanged;
  final String label;
  final Function validate;
  final TextEditingController controller;
  //final String onSaved;
  FormFieldSetter<String> onSaved;
  final bool expandable;
  final TextInputType;

  PrimaryTextField(
      {@required this.label,
      this.onChanged,
      this.validate,
      this.onSaved,
      this.expandable = false,
      this.controller,
      this.TextInputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: TextInputType,
      expands: expandable,
      maxLines: expandable ? null : 1,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.amber,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.orange[900],
            width: 1.0,
          ),
        ),
      ),

      // InputDecoration(

      //     // icon: Icon(Icons.supervised_user_circle),
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(15.0),
      //     ),
      //     labelText: label,
      //     alignLabelWithHint: true,

      //     ),
      onChanged: onChanged,
      validator: validate,
      onSaved: onSaved,
    );
  }
}
