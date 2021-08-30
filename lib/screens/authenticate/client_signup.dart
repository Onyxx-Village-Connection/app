import 'package:flutter/material.dart';
import 'package:ovcapp/screens/authenticate/client_login.dart';
import 'package:ovcapp/screens/authenticate/more_signup_info.dart';

final _backgroundColor = Colors.black;
final _widgetColor = Color(0xFFE0CB8F);

class ClientSignup extends StatefulWidget {
  ClientSignup({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientSignupState createState() => _ClientSignupState();
}

class _ClientSignupState extends State<ClientSignup> {
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

  Widget _buildClientSignupWidgets(BuildContext context) {
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
      style: textStyle,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Password',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
      },
      onChanged: (val) {
        setState(() => password = val);
      },
    );

    final nextButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: _widgetColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
        onPressed: () async {
          _navigateToMoreSignupInfoPage(context);
        },
        child: Text(
          'Next',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'BigShouldersDisplay',
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    final haveAccountTextButton = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account?',
            style: TextStyle(
                fontFamily: 'BarlowSemiCondensed',
                fontSize: 18.0,
                color: Colors.white),
          ),
          TextButton(
            onPressed: () => _navigateToClientLogin(context),
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'BarlowSemiCondensed',
                  color: _widgetColor),
            ),
          ),
        ],
      ),
    );

    return ListView(
      children: <Widget>[
        Image.asset(
          'images/ovclogo.png',
          height: 155,
          width: 155,
          scale: 1.2,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Text(
            'OVC serves its clients facing food insecurity by distributing food and making them aware of other helpful resources',
            textAlign: TextAlign.center,
            style: textStyle.copyWith(height: 2.0),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 8,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 15.0),
          child: emailBox,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: passwordBox,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(145.0, 20.0, 145.0, 15.0),
          child: nextButton,
        ),
        haveAccountTextButton,
      ],
    );
  }

  void _navigateToClientLogin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return ClientLogin(title: 'Client Login');
      },
    ));
  }

  void _navigateToMoreSignupInfoPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return MoreSignupInfo(
            title: 'More Signup Info', email: email, password: password);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final signupForm = Container(
      color: _backgroundColor,
      child: _buildClientSignupWidgets(context),
    );

    return Scaffold(
      body: signupForm,
    );
  }
}
