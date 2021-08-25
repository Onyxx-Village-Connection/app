import 'package:flutter/material.dart';
import 'package:ovcapp/screens/authenticate/client_signup.dart';
import 'package:ovcapp/services/client_auth.dart';


final _backgroundColor = Colors.black;
final _widgetColor = Color(0xFFE0CB8F);

class ClientLogin extends StatefulWidget {
  ClientLogin({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientLoginState createState() => _ClientLoginState();
}

class _ClientLoginState extends State<ClientLogin> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  TextStyle textStyle = TextStyle(fontSize: 20.0, color: Colors.white);
  TextStyle hintTextStyle = TextStyle(fontSize: 20.0, color: Colors.grey);

  OutlineInputBorder focusedField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );

  OutlineInputBorder enabledField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
      color: Colors.white10,
      width: 2.0,
    ),
  );

  Widget _buildClientLoginWidgets(BuildContext context) {
    final emailBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Email Address',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
      },
      onChanged: (val) {
        setState(() => email = val);
      },
    );

    final passwordBox = TextFormField(
      obscureText: true,
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Password',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      obscureText: true,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
      },
      onChanged: (val) {
        setState(() => password = val);
      },
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: _widgetColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        onPressed: () async {
          print(email);
          print(password);
        },
        child: Text(
          'Login',
          textAlign: TextAlign.center,
<<<<<<< HEAD
<<<<<<< HEAD
          style: textStyle.copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
=======
          //style: textStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold,),
>>>>>>> changing the do not have an account in the login screen according to the styling sheet
=======
          style: TextStyle(fontFamily: 'BigShouldersDisplay', fontSize: 25.0, fontWeight: FontWeight.bold),
>>>>>>> delete monserret fronts from file and all of the screen + the complete client login page with the standard style
        ),
      ),
    );

    final notHaveAccountTextButton = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Do not have an account?',
            style: TextStyle(fontFamily: 'BarlowSemiCondensed', fontSize: 18.0, color: Colors.white),
          ),
          TextButton(
            onPressed: () => _navigateToClientSignup(context),
            child: Text(
              'Sign up',
<<<<<<< HEAD
              style: textStyle.copyWith(
                fontSize: 18.0,
                decoration: TextDecoration.underline,
              ),
=======
              style: TextStyle(fontSize: 18.0, fontFamily: 'BarlowSemiCondensed', color: Color(0xFFE0CB8F)),
>>>>>>> changing the do not have an account in the login screen according to the styling sheet
            ),
          ),
        ],
      ),
    );

    return ListView(
<<<<<<< HEAD
      children: <Widget>[
        Image.asset(
          'images/ovclogo.png',
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
=======
        children: <Widget>[
          Image.asset(
            'images/ovclogo.png',
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
            padding: EdgeInsets.fromLTRB(150.0, 20.0, 150.0, 15.0),
            child: loginButton,
          ),
          notHaveAccountTextButton,
        ],
>>>>>>> delete monserret fronts from file and all of the screen + the complete client login page with the standard style
    );
  }

  void _navigateToClientSignup(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return ClientSignup(title: 'Client Signup');
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Container(
      color: _backgroundColor,
      child: _buildClientLoginWidgets(context),
    );

    return Scaffold(
      body: loginForm,
    );
  }
}
