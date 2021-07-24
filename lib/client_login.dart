import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientLogin extends StatefulWidget{
  ClientLogin({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientLoginState createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin>{

  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white);

  Widget _buildClientLoginWidgets(BuildContext context){

    return ListView(
      children: <Widget>[
        Image.asset(
          'assets/images/ovclogo.png',
          height: 155,
          width: 155,
          scale: 1.2,
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

