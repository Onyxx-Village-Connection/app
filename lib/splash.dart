import 'package:flutter/material.dart';
import 'package:ovcapp/landing.dart';
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
            "lib/assets/onyxx cropped.jpg",
            width: 500,
            height: 250,
            //fit: BoxFit.contain,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Making the Connection to Food, Resources,',
              style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 18, color: Color(0xFFFAEFC5)),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'and Compassion',
              style: TextStyle(fontFamily: "BarlowSemiCondensed", fontSize: 18, color: Color(0xFFFAEFC5)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(50.0),
            child: CircularProgressIndicator(
              color: Color(0xFFFAEFC5),
            ),
          ),
        ],
      ),
    );
  }
}

