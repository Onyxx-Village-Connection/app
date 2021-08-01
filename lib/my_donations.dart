// 'My Donations' screen for donor
import 'package:flutter/material.dart';
import 'package:ovcapp/new_donation.dart';
import 'package:ovcapp/donations.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  final myDonations = Donations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Donations'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return NewDonation(title: 'New Donation');
              }));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
