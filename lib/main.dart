import 'package:flutter/material.dart';
import 'package:ovcapp/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OVC App',
      theme: ThemeData.dark(),
      home: LandingPage(),
    );
  }
}
