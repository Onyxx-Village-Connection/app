import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './widgets/auth/helperFns.dart';
import './landing.dart';

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
      home: Authenticate(),
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return OnyxxLanding();
    } else {
      return FutureBuilder(
          future: getUserRole(user.uid),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return getLandingPage(snapshot.data!);
            } else {
              return CircularProgressIndicator();
            }
          });
    }
  }
}
