import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final Function onChanged;
  final Function validatorFun;
  final TextEditingController controller;
  final String label;

  PasswordTextField(
      {this.onChanged,
      this.validatorFun,
      this.controller,
      @required this.label});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(
          // backgroundColor: Colors.white,
          color: Colors.white,
          height: 0.5,
          fontFamily: 'beIN',
          fontWeight: FontWeight.bold,
          fontSize: 16),
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: TextStyle(color: Colors.white54),
       //  labelText: "كلمة السر",
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
