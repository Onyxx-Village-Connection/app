import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ovcapp/screens/authenticate/user_login.dart';

final _backgroundColor = Colors.black87;

class UserSignup extends StatefulWidget {
  UserSignup({Key? key, required this.role}) : super(key: key);

  final String role;
  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // global form key
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // message
  String _msg = '';

  TextStyle textStyle =
      TextStyle(fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.white);

  Future<String> signup(String email, String password) async {
    final form = _formKey.currentState;
    if (form != null && !form.validate()) {
      print("Error: please fill in the fields to sign up");
      setState(() {
        _msg = "Please fill in the fields to sign up";
      });
      return "";
    }

    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print("Failded to sign up with email " +
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

  Widget _buildUserSignupWidgets(BuildContext context) {
    final nameBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Your Name',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
      },
    );

    final emailBox = TextFormField(
      controller: _emailController,
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Email Address',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
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

    final phoneNumberBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Phone Number',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
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
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
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
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the length of time you have been involved';
        }
      },
    );

    final signupButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: Colors.amber,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(150.0, 0, 150.0, 0),
        onPressed: () {
          signup(_emailController.text, _passwordController.text)
              .then((userId) {
            if (userId == "") {
              print("Sorry, not able to sign you up as a new user");
              setState(() {
                _msg = "Failed to sign you up as a new user";
              });
            } else {
              print("Signed up new user with ID " + userId);
              setState(() {
                _msg = "You have signed up successfully";
              });
            }
          });
        },
        child: Text(
          'Sign up',
          textAlign: TextAlign.center,
          style: textStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final haveAccountTextButton = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account?',
            style: textStyle.copyWith(fontSize: 16.0),
          ),
          TextButton(
            onPressed: () => _navigateToUserLogin(context),
            child: Text(
              'Login',
              style: textStyle.copyWith(
                fontSize: 16.0,
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
          height: 155,
          width: 155,
          scale: 1.2,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(2.5, 0, 2.5, 0),
          child: Text(
            'OVC serves its clients facing food insecurity by distributing food and making them aware of other helpful resources',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
              height: 2.0,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 8,
          ),
        ),
        Form(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: nameBox,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: emailBox,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: passwordBox,
              ),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: phoneNumberBox,
              // ),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: cityBox,
              // ),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: howLongBox,
              // ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: signupButton,
              ),
              haveAccountTextButton,
              msg(),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToUserLogin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return UserLogin(role: widget.role);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final signupForm = Container(
      color: _backgroundColor,
      child: _buildUserSignupWidgets(context),
    );

    return Scaffold(
      body: signupForm,
    );
  }
}
