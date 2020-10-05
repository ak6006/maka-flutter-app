import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryNumberField extends StatelessWidget {
  final Function onChanged;
  final String label;
  final Function validate;
  final TextEditingController controller;
  //final String onSaved;
  FormFieldSetter<String> onSaved;
  final bool expandable;
  //final TextInputType;

  PrimaryNumberField({
    @required this.label,
    this.onChanged,
    this.validate,
    this.onSaved,
    this.expandable = false,
    this.controller,
    //this.TextInputType.number
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      controller: controller,
      style: TextStyle(
        height: 0.5,
        color: Colors.white,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
      expands: expandable,
      maxLines: expandable ? null : 1,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        // labelText: label,
        hintText: label,
        hintStyle: TextStyle(color: Colors.white54),
        //labelStyle: TextStyle(fontFamily: "Subtitle"),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.amber,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: Colors.orange[800],
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
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
