import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:ovcapp/screens/authenticate/client_signup.dart';
import 'profile_page.dart';
import 'volunteer_sign_in.dart';
import 'volunter_sign_up.dart';
import 'package:ovcapp/profile_page.dart';
import 'package:ovcapp/volunteer_pickup.dart';
import 'package:ovcapp/volunteer_sign_in.dart';
import 'package:ovcapp/volunteer_sign_up.dart';
import 'package:ovcapp/client_resources.dart';
import 'package:ovcapp/client_wishlist.dart';
import 'package:ovcapp/landing.dart';
import 'package:ovcapp/profile_page.dart';
import 'package:ovcapp/screens/authenticate/client_signup.dart';
import 'package:ovcapp/screens/authenticate/client_login.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:ovcapp/screens/authenticate/client_signup.dart';
import 'package:ovcapp/landing_page.dart';
import 'package:ovcapp/screens/map/map_screen.dart';
import 'package:ovcapp/splash.dart';
import 'package:ovcapp/volunteer_pickup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OnyxxApp());
  // runApp(MyApp());
}

class OnyxxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onyxx Village Connection',
      theme: ThemeData.dark(),
      home: LandingPage(),
      // home: SignIn(),
      // home: ClientSignup(title: 'Client Signup',),
      // home: ClientWishlist(title: 'Client Wishlist',),
      // home: ClientResources(title: 'Client Resources',),
      //home: ClientLogin(title: 'Client Login',),
      // home: Splash(),
      //home: LandingPage(),
      // home: MapScreen(),
    );
  }
}
