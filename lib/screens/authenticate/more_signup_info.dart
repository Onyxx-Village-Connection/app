import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ovcapp/screens/client/client_wishlist.dart';

final _backgroundColor = Colors.black;
final _widgetColor = Color(0xFFE0CB8F);

class MoreSignupInfo extends StatefulWidget{
  MoreSignupInfo({Key? key, required this.title, required this.email, required this.password}) : super(key: key);

  final String title, email, password;
  @override
  _MoreSignupInfoState createState() => _MoreSignupInfoState();
}

class _MoreSignupInfoState extends State<MoreSignupInfo>{


  String name = '';
  String phone = '';
  String city = '';
  String howLong = '';

  final _auth = FirebaseAuth.instance;

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

  Widget _buildMoreSignupInfoWidgets (BuildContext context){

    final nameBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Your Name',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your name';
        }
      },
      onChanged: (val){
        setState(() => name = val);
      },
    );

    final phoneNumberBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'Phone Number',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your phone number';
        }
      },
      onChanged: (val){
        setState(() => phone = val);
      },
    );

    final cityBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'City',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.all(20.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter your city';
        }
      },
      onChanged: (val){
        setState(() => city = val);
      },
    );

    final howLongBox = TextFormField(
      style: textStyle,
      decoration: InputDecoration(
        focusedBorder: focusedField,
        enabledBorder: enabledField,
        hintText: 'How long have you been with OVC?',
        hintStyle: hintTextStyle,
        contentPadding: EdgeInsets.fromLTRB(15.0, 20.0, 20.0, 30.0),
      ),
      validator: (String? value){
        if (value == null || value.isEmpty){
          return 'Please enter the length of time you have been involved';
        }
      },
      onChanged: (val){
        setState(() => howLong = val);
      },
    );

    final signupButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: _widgetColor,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
        onPressed: () async {
          await _auth.createUserWithEmailAndPassword(email: widget.email, password: widget.password).then((_){
            User? client = _auth.currentUser;
            clientSetup(name, phone, city, howLong);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ClientWishlist(title: 'Client Wishlist')));
          });
          },
        child: Text(
          'Sign up',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'BigShouldersDisplay', fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'We need more information from you...',
            textAlign: TextAlign.center,
            style : textStyle.copyWith(fontSize: 20.0),
          ) ,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          child: nameBox,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: phoneNumberBox,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: cityBox,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
          child: howLongBox,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(130.0, 20.0, 130.0, 15.0),
          child: signupButton,
        ),
      ],
    );
  }

  Future<void> clientSetup(String name, String phone, String city, String howLong) async {
    CollectionReference clients = FirebaseFirestore.instance.collection('Clients');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    clients.add({'uid': uid, 'name': name, 'phone': phone, 'city': city, 'how long with OVC': howLong});
    return;
  }

  @override
  Widget build(BuildContext context){

    final moreSignupInfoForm = Container(
      color: _backgroundColor,
      child: _buildMoreSignupInfoWidgets(context),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        iconTheme: IconThemeData(
          color: _widgetColor,
        ),
        backgroundColor: _backgroundColor,
      ),

      body: moreSignupInfoForm,
    );
  }
}