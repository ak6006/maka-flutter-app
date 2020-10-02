import 'package:flutter/material.dart';

class ConfirmPassTextField extends StatefulWidget {
  final Function onChanged;
  final Function validatorFun;
  final TextEditingController controller;
  final String label;

  ConfirmPassTextField(
      {this.onChanged,
      this.validatorFun,
      this.controller,
      @required this.label});

  @override
  _ConfirmPassTextFieldState createState() => _ConfirmPassTextFieldState();
}

class _ConfirmPassTextFieldState extends State<ConfirmPassTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(
        // backgroundColor: Colors.white,
        color: Colors.white,
      ),
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: "تأكيد كلمة السر ",
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
            width: 2.0,
          ),
        ),
      ),
      //InputDecoration(

      //   suffixIcon: IconButton(
      //     icon: Icon(Icons.visibility),
      //     onPressed: () {
      //       setState(() {
      //         _obscure = !_obscure;
      //       });
      //     },
      //   ),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(15.0),
      //   ),
      //   labelText: 'كلمة السر',
      // ),
      onChanged: widget.onChanged,
      validator: widget.validatorFun,
    );
  }
}
