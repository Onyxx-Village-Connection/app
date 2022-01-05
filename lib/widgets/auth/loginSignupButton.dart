import 'package:flutter/material.dart';

import './styleConstants.dart';

class LoginSignupButton extends StatelessWidget {
  const LoginSignupButton(this.buttonTitle, this.onPressedFn, {Key? key})
      : super(key: key);

  final String buttonTitle;
  final VoidCallback onPressedFn;

  bool isGenericButton() {
    return (buttonTitle == 'Login' ||
            buttonTitle == 'Logout' ||
            buttonTitle == 'Sign Up')
        ? false
        : true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: this.buttonTitle == 'Logout' ? Colors.blue : widgetColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        onPressed: onPressedFn,
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'BigShouldersDisplay',
              fontSize: isGenericButton() ? 16.0 : 25.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
