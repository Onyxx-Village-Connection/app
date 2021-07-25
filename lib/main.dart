import 'package:flutter/material.dart';

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
      home: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'images/OVC-logo-cropped.jpg',
                  ),
                ),
                roleButton('Donor'),
                roleButton('Volunteer'),
                roleButton('client'),
              ],
            ),
          )),
    );
  }

  Padding roleButton(String role) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () {
          print('${role} click');
        },
        child: Text(
          'I am a ${role}',
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          primary: Colors.black,
          padding: EdgeInsets.all(5.0),
          minimumSize: Size(200, 40),
          textStyle: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
