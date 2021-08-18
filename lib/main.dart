import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:ovcapp/screens/authenticate/client_signup.dart';
import 'package:ovcapp/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OVC App',
      //theme: ThemeData(
      //primarySwatch: Colors.blue,
      //),
      //home: ClientSignup(title: 'Client Signup',),
      theme: ThemeData.dark(),
      home: LandingPage(),
    );
  }
}
