import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final Function onChanged;
  final Function validatorFun;
  PasswordTextField({this.onChanged, this.validatorFun});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        // backgroundColor: Colors.white,
        color: Colors.white,
      ),
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: "كلمة السر",
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
            color: Colors.white,
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
