// 'My Donations' screen for donor
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ovcapp/widgets/auth/helperFns.dart';

import '../authenticate/user_profile_info.dart';
import '../../assets/ovcicons.dart';
import './new_donation.dart';
import './donation.dart';
import '../../widgets/auth/styleConstants.dart';

class MyDonations extends StatefulWidget {
  const MyDonations({Key? key}) : super(key: key);

  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  final List<Donation> donations = [];
  final firestoreInstance = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  var donation = new Donation();

  void _addDonation() async {
    Route route = MaterialPageRoute(
        builder: (context) => NewDonation(donation: donation));
    donation = await Navigator.push(context, route);
    donation.userId = userId;
    donation.docId = firestoreInstance.collection("donations").doc().id;
    if (donation.itemImg != null) {
      donation.itemImgUrl =
          await uploadItemImage(donation.itemImg!, donation.docId);
    }
    await firestoreInstance
        .collection("donations")
        .doc(donation.docId)
        .set(donation.toJson());
    setState(() {
      donations.add(donation);
      // clear the donation object
      donation = new Donation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Donations'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(OVCIcons.profileicon),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserProfileInfo(role: 'Donor')),
              );
            },
          ),
        ],
      ),
      body: donationsList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add a new donation',
        backgroundColor: widgetColor,
        onPressed: _addDonation,
      ),
    );
  }

  Widget donationsList(BuildContext context) {
    return StreamBuilder(
      stream: firestoreInstance
          .collection("donations")
          .where("userId", isEqualTo: userId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapShot) {
        if (streamSnapShot.hasData) {
          return ListView.builder(
            itemCount: streamSnapShot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapShot.data!.docs[index];
              Donation donation = Donation.fromJson(
                  documentSnapshot.data() as Map<String, dynamic>);
              return Card(
                child: ListTile(
                  leading: Icon(
                    Icons.fastfood,
                    color: Colors.purple,
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewDonation(donation: donation)),
                    );
                  },
                  title: Text(
                    donation.name,
                    style: TextStyle(fontSize: 24, color: widgetColor),
                  ),
                ),
              );
            },
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
