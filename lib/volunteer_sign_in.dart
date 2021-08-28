import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/profile_page.dart';
import 'package:ovcapp/volunteer_pickup.dart';
import 'package:ovcapp/volunteer_sign_up.dart';
import 'package:ovcapp/volunteerlog/volunteer/volunteer.dart';
import 'constants.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  String userEmail = "";
  String userPassword = "";
  String error = "";
  Color colorOfBanner = kSecondaryColor;
  Widget showErrorBanner() {
    if (error != "") {
      return Column(
        children: [
          SizedBox(
            height: 27.5,
          ),
          Container(
            width: double.infinity,
            color: Colors.red,
            height: 72.5,
            child: Center(
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 27.5,
          ),
        ],
      );
    }
    return SizedBox(
      height: 75,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                showErrorBanner(),
                Container(
                  width: 238.0,
                  height: 151.0,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.onyxxvillageconnection.org/wp-content/uploads/2020/08/OVC-logo-cropped.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userEmail = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userPassword = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (!EmailValidator.validate(userEmail)) {
                          setState(() {
                            error = "The email address entered is invalid";
                          });
                        } else if (userPassword == "") {
                          setState(() {
                            error = "Enter a password";
                          });
                        }
                        try {
                          final registeredUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: userEmail, password: userPassword);
                          if (userEmail != "" || userPassword != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabBuilder(volunteer: Volunteer.matchingCredentials(userEmail))),
                            );
                          }
                        } catch (e) {
                          print(e);
                          setState(() {
                            error = e.toString();
                          });
                        }
                      },
                      minWidth: 200,
                      height: 42,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: Text(
                    'Don\'t already have an account?',
                    style: TextStyle(
                      color: kSecondaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
