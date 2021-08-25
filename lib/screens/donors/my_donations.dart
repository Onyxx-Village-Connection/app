// 'My Donations' screen for donor
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ovcapp/screens/donors/new_donation.dart';
import 'package:ovcapp/screens/donors/donation.dart';
import 'package:ovcapp/screens/donors/donor_profile.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  final List<Donation> donations = [];
  final firestoreInstance = FirebaseFirestore.instance;

  var donation = new Donation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Donations'),
        actions: [
          IconButton(
            // add new donation
            onPressed: () async {
              Route route = MaterialPageRoute(
                  builder: (context) => NewDonation(donation: donation));
              donation = await Navigator.push(context, route);
              donation.userId = widget.userId;
              donation.docId =
                  firestoreInstance.collection("donations").doc().id;
              firestoreInstance
                  .collection("donations")
                  .doc(donation.docId)
                  .set(donation.toJson());
              setState(() {
                donations.add(donation);
              });
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            // update donor profile
            onPressed: () {
              Route route = MaterialPageRoute(
                  builder: (context) => DonorProfile(userId: widget.userId));
              Navigator.push(context, route);
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: donationsList(context),
    );
  }

  Widget donationsList(BuildContext context) {
    // var donations = DonationsProvider.of(context).donations;
    return StreamBuilder(
      stream: firestoreInstance
          .collection("donations")
          .where("userId", isEqualTo: widget.userId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapShot) {
        if (streamSnapShot.hasData) {
          print("At donationsList widget, num of donations: " +
              streamSnapShot.data!.docs.length.toString());
          return ListView.builder(
            itemCount: streamSnapShot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapShot.data!.docs[index];
              Donation donation = Donation.fromJson(
                  documentSnapshot.data() as Map<String, dynamic>);
              return ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                title: Text(
                  donation.name,
                  style: TextStyle(fontSize: 24, color: Colors.yellow),
                ),
              );
            },
            // return ListTile(
            //   leading: IconButton(
            //     onPressed: () {
            //       print("Before refresh, num of donations: " +
            //           donations.length.toString());
            //       setState(() {});
            //       print("After refresh, num of donations: " +
            //           donations.length.toString());
            //     },
            //     icon: const Icon(Icons.refresh),
            //   ),
            //   title: Text('refresh'),
            // );
          );
        } else {
          return ListTile(
            title: Text('No donations yet'),
          );
        }
      },
    );
  }
}
