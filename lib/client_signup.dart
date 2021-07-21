import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final _backgroundColor = Colors.black87;

class ClientSignup extends StatefulWidget{
  ClientSignup({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _ClientSignupState createState() => _ClientSignupState();
}

class _ClientSignupState extends State<ClientSignup>{

  TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0, color: Colors.white);

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

  Widget _buildClientSignupWidgets(BuildContext context){

    final nameBox = TextFormField(
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Your Name',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your name';
        }
      },
    );

    final emailBox = TextFormField(
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Email Address',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your email address';
        }
      },
    );

    final phoneNumberBox = TextFormField(
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Phone Number',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your phone number';
        }
      },
    );

    final cityBox = TextFormField(
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'City',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your city';
        }
      },
    );

    final howLongBox = TextFormField(
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'How long have you been with OVC?',
        hintStyle: textStyle,
        contentPadding: EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter the length of time you have been involved';
        }
      },
    );

    final signupButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: Colors.amber,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30.0, 2.5, 30.0, 2.5),
        onPressed: (){},
        child: Text(
          'Sign up',
          textAlign: TextAlign.center,
          style: textStyle.copyWith(fontWeight: FontWeight.bold,),
        ),
      ),
    );

    return ListView(
      children: <Widget> [
        Image.asset(
          'assets/images/ovclogo.png',
          height: 115,
          width: 115,
          scale: 1.5,
        ),
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'OVC serves its clients facing food insecurity by distributing food and making them aware of other helpful resources',
              textAlign: TextAlign.center,
              style:
              TextStyle(
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
                SizedBox(height: 10.0,),
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
                  child: phoneNumberBox,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: cityBox,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: howLongBox,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: signupButton,
                )
              ],
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
