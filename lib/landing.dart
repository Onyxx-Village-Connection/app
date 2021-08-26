import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//official landing page - Advik Kunta (for reference because
//there's another landing page that I don't want to delete)
class OnyxxLanding extends StatelessWidget{
  const OnyxxLanding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 100),
            child: Image.asset(
              "lib/assets/onyxx.jpg",
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 75, top: 10, right: 75, bottom: 10),
            child: OutlinedButton(

              child: Text('I Am A Donor'),
              // in this onPressed add navigation to donor

              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE0CB8F)),
                foregroundColor:MaterialStateProperty.all<Color>(Colors.black),
                overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(30))
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 75, top: 10, right: 75, bottom: 10),
            child: OutlinedButton(
              child: Text('I Am A Volunteer'),
              // In the onPressed area, add the navigation to the volunteer signup page
              onPressed: () {},

              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE0CB8F)),
                foregroundColor:MaterialStateProperty.all<Color>(Colors.black),
                overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(30)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 75, top: 10, right: 75, bottom: 10),
            child: OutlinedButton(
              child: Text('I Am A Client'),
              //add navigation to client signup
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE0CB8F)),
                foregroundColor:MaterialStateProperty.all<Color>(Colors.black),
                overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(30))
              ),
            ),
          )
        ],

      ),
    );

  }
}