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
        contentPadding: EdgeInsets.all(20.0),
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
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your phone number';
        }
      },
    );

    final cityBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'City',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your city';
        }
      },
    );

    final howLongBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'How long have you been with OVC?',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter the length of time you have been involved';
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
        Padding(
          padding: EdgeInsets.all(10.0),
          child: cityBox,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: howLongBox,
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
      appBar: AppBar(
        elevation: 1.0,
        iconTheme: IconThemeData(
          color: Colors.amber,
        ),
        backgroundColor: _backgroundColor,
      ),

      body: moreSignupInfoForm,
    );
  }
}