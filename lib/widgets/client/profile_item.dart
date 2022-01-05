import 'package:flutter/material.dart';

import '../../widgets/auth/styleConstants.dart';

class ProfileItem extends StatelessWidget {
  final String hintText;
  final Function validatorFn;
  final bool isEditing;
  final TextEditingController controller;

  ProfileItem(this.hintText, this.isEditing, this.validatorFn, this.controller,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      enabled: isEditing,
      controller: controller,
      decoration: InputDecoration(
        // focusedBorder: focusedField,
        // enabledBorder: enabledField,
        errorBorder: errorField,
        focusedErrorBorder: errorField,
        filled: !isEditing,
        labelText: hintText,
        labelStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      textInputAction: TextInputAction.next,
      validator: (String? value) {
        return validatorFn(value);
      },
    );
  }
}
