import 'package:flutter/material.dart';
import 'package:ovcapp/screens/authenticate/user_login.dart';
// import 'package:ovcapp/screens/donors/my_donations.dart';
import 'package:ovcapp/screens/authenticate/client_login.dart';
import 'package:ovcapp/volunteer_sign_up.dart';

class LandingPage extends StatelessWidget {
  // This widget is the landing page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'images/ovclogo.png',
              ),
            ),
            roleButton(context, 'Donor'),
            roleButton(context, 'Volunteer'),
            roleButton(context, 'Client'),
          ],
        ),
      ),
    );
  }

  Padding roleButton(BuildContext context, String role) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () {
          print('$role click');
          _navigateToRole(context, role);
        },
        child: Text(
          'I am a $role',
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

  void _navigateToRole(BuildContext context, String role) {
    switch (role) {
      case 'Donor':
        {
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            // return MyDonations(title: 'Donor');
            return UserLogin(role: role);
          }));
        }
        break;
        case 'Volunteer':
        {
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return SignUp();
          }));
        }
        break;
      case 'Client':
        {
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return ClientLogin(title: 'Client');
          }));
        }
        break;
      default:
        {}
        break;
    }
  }
}
