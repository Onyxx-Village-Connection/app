import 'package:flutter/material.dart';
import 'package:ovcapp/client_resources.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ovcapp/client_wishlist.dart';
import 'package:ovcapp/screens/authenticate/client_signup.dart';
import 'package:ovcapp/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OnyxxApp());
}

class OnyxxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onyxx Village Connection',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      home: Splash(),
    );
  }
}