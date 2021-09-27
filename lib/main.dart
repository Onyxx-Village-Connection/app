import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// SS: import 'package:ovcapp/landing_page.dart';
//import 'package:untitled/splash.dart';


import 'package:ovcapp/client_resources.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ovcapp/client_wishlist.dart';
import 'package:ovcapp/landing.dart';
import 'package:ovcapp/profile_page.dart';
import 'package:ovcapp/screens/authenticate/client_signup.dart';
import 'package:ovcapp/screens/authenticate/client_login.dart';
import 'package:ovcapp/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ovcapp/screens/map/map_screen.dart';
import 'package:ovcapp/splash.dart';
import 'package:ovcapp/volunteer_pickup.dart';


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
      title: 'OVC app',
      //home: ClientWishlist(title: 'Client Wishlist',),
      //home: ClientResources(title: 'Client Resources',),
      //home: ClientLogin(title: 'Client Login',),
      theme: ThemeData.dark(),
      home: LandingPage(),
      //home: LandingPage(),
      //home: MapScreen(),
    );
  }
}
