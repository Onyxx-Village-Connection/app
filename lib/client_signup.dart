import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientSignup extends StatelessWidget{
  const  ClientSignup();

  Widget _buildClientSignupWidgets(BuildContext context){
    return ListView(
      children: <Widget> [
        Image.asset(
          'assets/images/ovclogo.png',
          height: 165,
          width: 165,
          scale: 1.5,
        ),
        Text(
          'OVC serves its clients facing food insecurity by distributing food and making them aware of other helpful resources',
          textAlign: TextAlign.center,
          style:
          TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 2.0,
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 8,
        ),
      ],
    );
  }

  void _navigateToDonatingFood(BuildContext context){

  }

  @override
  Widget build(BuildContext context){

    final signupForm = Container(
      color: _backgroundColor,
      child: _buildClientSignupWidgets(context),
    );

    return Scaffold(
      body: signupForm,
    );
  }
}
