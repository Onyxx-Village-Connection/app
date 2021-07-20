import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientSignup extends StatefulWidget{
  ClientSignup({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientSignupState createState() => _ClientSignupState();
}

class _ClientSignupState extends State<ClientSignup>{

  Widget _buildClientSignupWidgets(BuildContext context){

    final inputBox = TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.amberAccent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.amber,
            width: 2.0,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

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
        Form(
            child: Column(

            ),
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
