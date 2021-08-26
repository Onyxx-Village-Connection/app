import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ovcapp/profile_page.dart';
import 'package:ovcapp/volunteer_pickup.dart';
import 'package:ovcapp/volunteer_sign_in.dart';
import 'package:ovcapp/volunteer_sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OVC App', theme: ThemeData.dark(), home: SignIn());
  }
}
