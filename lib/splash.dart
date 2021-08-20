import 'package:flutter/material.dart';
import 'package:untitled/landing.dart';
import 'package:google_fonts/google_fonts.dart';
//Splash page - will focus on this for 2 seconds then redirect to landing.dart
//So, combine whatever you need from landing_page.dart to landing.dart and all will work
class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnyxxLanding()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "lib/assets/onyxx.jpg",
            width: 500,
            height: 400,
            fit: BoxFit.contain,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Making the Connection to Food, Resources, and Compassion',
              style: GoogleFonts.satisfy(textStyle: TextStyle(fontSize: 25)),
            ),
          ),
        ],
      ),
    );
  }
}

