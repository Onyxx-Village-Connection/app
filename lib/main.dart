import 'package:flutter/material.dart';
import 'package:ovcapp/client_resources.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ovcapp/client_wishlist.dart';
import 'package:ovcapp/screens/authenticate/client_signup.dart';
import 'package:ovcapp/screens/authenticate/client_login.dart';
import 'package:ovcapp/landing_page.dart';
import 'themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OVC app',
      //home: ClientWishlist(title: 'Client Wishlist',),
      //ClientResources(title: 'Client Resources',),
      home: ClientLogin(title: 'Client Login',),
    );
  }
}