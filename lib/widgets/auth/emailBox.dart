import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import './styleConstants.dart';

class EmailBox extends StatelessWidget {
  const EmailBox(this.focusNode, this.nextFocusNode, this.onSavedFn, {Key? key})
      : super(key: key);

  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final Function onSavedFn;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        errorBorder: errorField,
        focusedErrorBorder: errorField,
        hintText: 'Email Address',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      focusNode: focusNode,
      validator: (String? value) {
        if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (val) {
        onSavedFn(val);
      },
    );
  }
}
