import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText,
        hintStyle:
            TextStyle(color: Color.fromARGB(255, 169, 168, 168), fontSize: 25),
        labelText: labelText,
        labelStyle:
            TextStyle(color: Color.fromARGB(255, 73, 72, 72), fontSize: 30),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Color.fromARGB(205, 70, 4, 252),
                size: 50,
              )
            : null);
  }
}
