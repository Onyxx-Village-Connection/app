import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class MoreSignupInfo extends StatefulWidget{
  MoreSignupInfo({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MoreSignupInfoState createState() => _MoreSignupInfoState();
}

class _MoreSignupInfoState extends State<MoreSignupInfo>{

  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white);

  OutlineInputBorder focusedField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(
      color: Colors.amberAccent,
    ),
  );

  OutlineInputBorder enabledField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(
      color: Colors.amber,
      width: 2.0,
    ),
  );



  @override
  Widget build(BuildContext context){

    final moreSignupInfoForm = Container(
      color: _backgroundColor,
      child: _buildMoreSignupInfoWidgets(context),
    );

    return Scaffold(
      body: moreSignupInfoForm,
    );
  }
}