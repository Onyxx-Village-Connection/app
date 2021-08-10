import 'package:flutter/material.dart';
import 'package:ovcapp/client_signup.dart';

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

    final passwordBox = TextFormField(
      style: textStyle,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Password',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your password';
        }
      },
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: Colors.amber,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
        onPressed: (){},
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: textStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold,),
        ),
      ),
    );

    final notHaveAccountTextButton = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(
            'Do not have an account?',
            style: textStyle.copyWith(fontSize: 18.0),
          ),
          TextButton(
            onPressed: () => _navigateToClientSignup(context),
            child: Text(
              'Sign up',
              style: textStyle.copyWith(fontSize: 18.0, decoration: TextDecoration.underline,),
            ),
          ),
        ],
      ),
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
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
            child: passwordBox,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
            child: loginButton,
          ),
          notHaveAccountTextButton,
        ],
    );
  }

  void _navigateToClientSignup(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context){
        return ClientSignup(title: 'Client Signup');
      },
    ));
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

