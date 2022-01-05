import 'package:flutter/material.dart';

import './styleConstants.dart';

class InputBox extends StatelessWidget {
  const InputBox(this.hintText, this.focusNode, this.nextFocusNode,
      this.validatorFn, this.controller,
      {Key? key})
      : super(key: key);

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final hintText;
  final Function validatorFn;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        errorBorder: errorField,
        focusedErrorBorder: errorField,
        hintText: hintText,
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      focusNode: focusNode,
      validator: (String? value) {
        return validatorFn(value);
      },
    );
  }
}
