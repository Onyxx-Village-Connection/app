import 'package:flutter/material.dart';

final Color backgroundColor = Colors.black;
final Color widgetColor = Color(0xFFE0CB8F);

TextStyle textStyle = TextStyle(fontSize: 20.0, color: Colors.white);
TextStyle hintTextStyle = TextStyle(fontSize: 20.0, color: Colors.grey);

OutlineInputBorder focusedField = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

OutlineInputBorder enabledField = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: BorderSide(
    color: Colors.white10,
    width: 2.0,
  ),
);

OutlineInputBorder errorField = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: BorderSide(
    color: Colors.red,
    width: 2.0,
  ),
);
