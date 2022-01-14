import 'package:flutter/material.dart';

import './styleConstants.dart';

class InputBox extends StatelessWidget {
  const InputBox(
      {this.hintText,
      this.focusNode,
      this.nextFocusNode,
      required this.validatorFn,
      required this.controller,
      this.enabled = true,
      Key? key})
      : super(key: key);

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final hintText;
  final Function validatorFn;
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        style: textStyle,
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          focusedBorder: focusedField,
          enabledBorder: enabledField,
          errorBorder: errorField,
          focusedErrorBorder: errorField,
          labelText: hintText,
          hintText: hintText,
          helperStyle: helperTextStyle,
          hintStyle: hintTextStyle,
          contentPadding: EdgeInsets.all(10.0),
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
      ),
    );
  }
}
