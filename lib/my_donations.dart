// 'My Donations' screen for donor
import 'package:flutter/material.dart';
import 'package:ovcapp/new_donation.dart';
import 'package:ovcapp/donation.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  final List<Donation> donations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Donations'),
        actions: [
          IconButton(
            onPressed: () async {
              Route route = MaterialPageRoute(
                  builder: (context) => NewDonation(title: 'New Donation'));
              Donation newDonation = await Navigator.push(context, route);
              setState(() {
                donations.add(newDonation);
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: donationsList(context),
    );
  }

  Widget donationsList(BuildContext context) {
    // var donations = DonationsProvider.of(context).donations;
    print("At donationsList widget, num of donations: " +
        donations.length.toString());
    return ListView.builder(
      itemCount: donations.length + 1,
      itemBuilder: (context, index) {
        if (index < donations.length) {
          Donation donation = donations[index];
          return ListTile(
            title: Text(donation.name),
          );
        } else {
          return ListTile(
            leading: IconButton(
              onPressed: () {
                print("Before refresh, num of donations: " +
                    donations.length.toString());
                setState(() {});
                print("After refresh, num of donations: " +
                    donations.length.toString());
              },
              icon: const Icon(Icons.refresh),
            ),
            title: Text('refresh'),
          );
        }
      },
    );
  }

  // FutureOr onGoBack(dynamic value) {
  //   setState(() {});
  // }
}
