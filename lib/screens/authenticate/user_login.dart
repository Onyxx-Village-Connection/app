import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ovcapp/screens/authenticate/user_signup.dart';
import 'package:ovcapp/screens/donors/my_donations.dart';

final _backgroundColor = Colors.black87;

class UserLogin extends StatefulWidget {
  UserLogin({Key? key, required this.role}) : super(key: key);

  final String role;
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // global form key
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // message
  String _msg = '';

  TextStyle textStyle =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);

  Future<String> login(String email, String password) async {
    final form = _formKey.currentState;
    if (form != null && !form.validate()) {
      print("Error: please fill in the fields to log in");
      setState(() {
        _msg = "Please fill in the fields to log in";
      });
      return "";
    }

    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print("Failded to log in with email " +
          email +
          ' and password ' +
          password);
      print("Error: " + e.toString());
      return "";
    }
  }

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

  Widget _buildUserLoginWidgets(BuildContext context) {
    final emailBox = TextFormField(
      controller: _emailController,
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Email Address',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
      },
    );

    final passwordBox = TextFormField(
      controller: _passwordController,
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Password',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      obscureText: true,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
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
        onPressed: () {
          login(_emailController.text, _passwordController.text).then((userId) {
            if (userId == "") {
              print("Sorry, not able to log you in");
              setState(() {
                _msg = "Failed to sign you in";
              });
            } else {
              print("Logged in with ID " + userId);
              setState(() {
                _msg = "You have logged in successfully";
              });
            }
            Navigator.of(context)
                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
              return MyDonations(userId: userId);
            }));
          });
        },
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: textStyle.copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final notHaveAccountTextButton = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Do not have an account?',
            style: textStyle.copyWith(fontSize: 18.0),
          ),
          TextButton(
            onPressed: () => _navigateToUserSignup(context),
            child: Text(
              'Sign up',
              style: textStyle.copyWith(
                fontSize: 18.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );

    Widget msg() {
      return Text(
        _msg,
        style: textStyle.copyWith(
          fontSize: 16,
        ),
      );
    }

    return ListView(
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
        msg(),
      ],
    );
  }

  void _navigateToUserSignup(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return UserSignup(role: widget.role);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Container(
      color: _backgroundColor,
      child: _buildUserLoginWidgets(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.role + ' Login'),
      ),
      body: loginForm,
    );
  }
}
