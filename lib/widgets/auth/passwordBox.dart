import 'package:flutter/material.dart';

import './styleConstants.dart';

class PasswordBox extends StatelessWidget {
  const PasswordBox(this.focusNode, this.onSavedFn, {Key? key})
      : super(key: key);

  final FocusNode focusNode;
  final Function onSavedFn;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        errorBorder: errorField,
        focusedErrorBorder: errorField,
        hintText: 'Password',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      focusNode: focusNode,
      validator: (String? value) {
        if (value == null || value.isEmpty || value.length < 8) {
          return 'Password must have atleast 8 characters';
        }
      },
      onSaved: (val) {
        onSavedFn(val);
      },
    );
  }
}
