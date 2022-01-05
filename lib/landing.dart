import 'package:flutter/material.dart';
import 'package:ovcapp/screens/authenticate/client_login.dart';

class OnyxxLanding extends StatelessWidget {
  const OnyxxLanding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          roleButton(context, 'Donor'),
          roleButton(context, 'Volunteer'),
          roleButton(context, 'Client'),
        ],
      ),
    );
  }

  Padding roleButton(BuildContext context, String role) {
    return Padding(
      padding: const EdgeInsets.only(left: 75, top: 10, right: 75, bottom: 10),
      child: OutlinedButton(
        onPressed: () {
          _navigateToRole(context, role);
        },
        child: Text(
          'I am a $role',
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFFE0CB8F)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(30))),
      ),
    );
  }

  void _navigateToRole(BuildContext context, String role) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ClientLogin(role: role)));
    // switch (role) {
    //   case 'Donor':
    //     {
    //       Navigator.of(context)
    //           .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    //         // return MyDonations(title: 'Donor');
    //         return UserLogin(role: role);
    //       }));
    //     }
    //     break;
    //   case 'Volunteer':
    //     {
    //       Navigator.of(context)
    //           .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    //         return SignUp();
    //       }));
    //     }
    //     break;
    //   case 'Client':
    //     {
    //       Navigator.of(context)
    //           .push(MaterialPageRoute<void>(builder: (BuildContext context) {
    //         return ClientLogin(role: role);
    //       }));
    //     }
    //     break;
    //   default:
    //     {}
    //     break;
    // }
  }
}
