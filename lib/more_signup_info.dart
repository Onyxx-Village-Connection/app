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

  Widget _buildMoreSignupInfoWidgets (BuildContext context){

    final nameBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Your Name',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your name';
        }
      },
    );

    final phoneNumberBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Phone Number',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your phone number';
        }
      },
    );

    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'We need some more information from you...',
            textAlign: TextAlign.center,
            style : textStyle.copyWith(fontSize: 20.0, height: 2.0, fontWeight: FontWeight.bold),
          ) ,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: nameBox,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: phoneNumberBox,
        ),
      ],
    );
  }

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