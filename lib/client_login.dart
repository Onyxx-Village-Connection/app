import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientLogin extends StatefulWidget{
  ClientLogin({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientLoginState createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin>{

  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);

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

  Widget _buildClientLoginWidgets(BuildContext context){

    final emailBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Email Address',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your email address';
        }
      },
    );

    return ListView(
        children: <Widget>[
          Image.asset(
            'assets/images/ovclogo.png',
            height: 250,
            width: 250,
            scale: 1.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 15.0),
            child: emailBox,
          ),
        ],
      );
  }


  @override
  Widget build(BuildContext context){

    final loginForm = Container(
      color: _backgroundColor,
      child: _buildClientLoginWidgets(context),
    );

    return Scaffold(
      body: loginForm,
    );
  }
}

