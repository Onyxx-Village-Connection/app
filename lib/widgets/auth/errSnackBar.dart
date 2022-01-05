import 'package:flutter/material.dart';

import './styleConstants.dart';

class ErrSnackBar {
  static show(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg,
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'BarlowSemiCondensed',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
        padding: EdgeInsets.all(15.0),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        margin: EdgeInsets.all(40),
      ),
    );
  }
}
