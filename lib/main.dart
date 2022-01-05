import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './landing.dart';
import './core/providers/authentication.dart';
import './screens/client/client_home_tabs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OnyxxApp());
}

class OnyxxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationState>(
            create: (_) => AuthenticationState()),
        StreamProvider<UserModels?>.value(
          initialData: null,
          value: AuthenticationState().user,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Onyxx Village Connection',
        theme: ThemeData.dark(),
        home: Authenticate(),
      ),
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModels?>(context);
    if (user == null) {
      print('User not logged in!');
      return OnyxxLanding();
    } else {
      print('User is logged in!');
      return ClientHomeTabBarScreen();
    }
  }
}
