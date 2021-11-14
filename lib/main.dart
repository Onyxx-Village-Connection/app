import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ovcapp/splash.dart';

Future<void> main() async {
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
      theme: ThemeData.dark(),
      home: Splash(),
      // home: LandingPage(),
    );
  }
}
