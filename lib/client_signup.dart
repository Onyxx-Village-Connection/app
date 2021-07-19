import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientSignup extends StatelessWidget{
  const  ClientSignup();

  Widget _buildClientSignupWidgets(BuildContext context){
    return ListView(
      children: <Widget> [
        Container(
          child: Image.asset('assets/images/ovclogo.png'),
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
