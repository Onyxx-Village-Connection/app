import 'package:flutter/material.dart';

import './styleConstants.dart';

class TextLinkButton extends StatelessWidget {
  const TextLinkButton(this.linkTitle, this.buttonTitle, this.onPressedFn,
      {Key? key})
      : super(key: key);

  final String linkTitle;
  final String buttonTitle;
  final Function onPressedFn;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            linkTitle,
            style: TextStyle(
                fontFamily: 'BarlowSemiCondensed',
                fontSize: 18.0,
                color: Colors.white),
          ),
          TextButton(
            onPressed: () => onPressedFn(context),
            child: Text(
              buttonTitle,
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'BarlowSemiCondensed',
                  color: widgetColor),
            ),
          ),
        ],
      ),
    );
  }
}
