import 'package:flutter/material.dart';

class SuggestionsTextField extends StatelessWidget {
  final Function onChanged;
  final String label;
  final Function validate;
  final TextEditingController controller;
  //final String onSaved;
  FormFieldSetter<String> onSaved;
  final bool expandable;
  final TextInputType;

  SuggestionsTextField(
      {@required this.label,
      this.onChanged,
      this.validate,
      this.onSaved,
      this.expandable = false,
      this.controller,
      this.TextInputType});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final maxLines = 5;
    return Container(
      //margin: EdgeInsets.all(12),
      height: maxLines * 24.0,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            //height: size.height * 0.02,
            // width: size.width * 0.8,
            color: Colors.white,
            fontFamily: 'beIN',
            fontWeight: FontWeight.bold,
            fontSize: 16),
        keyboardType: TextInputType,
        expands: expandable,
        maxLines: expandable ? null : 1,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.right,
        // maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 150, bottom: 0, right: 20, left: 0),
          // labelText: label,
          isDense: true,
          hintText: label,
          //prefixText: label,
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
      ),
    );
  }
}
