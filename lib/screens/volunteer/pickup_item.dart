import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/auth/styleConstants.dart';
import '../../core/models/donor_model.dart';
import '../../themes.dart';
import '../donors/donation.dart';
import 'package:intl/intl.dart';

class PickupItem extends StatelessWidget {
  final Donation donation;
  final DonorModel donor;

  PickupItem({required this.donation, required this.donor});

  bool isBeingPickedUp() {
    if (donation.pickupVolunteerId == FirebaseAuth.instance.currentUser!.uid &&
        donation.pickupCompletedAt == null) {
      return true;
    }
    return false;
  }

  Widget showAddress() {
    return Column(
      children: [
        Text(
          "Pickup From:",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23,
              fontFamily: "BarlowSemiCondensed"),
        ),
        Text(
          donor.pickupAddress,
          style: TextStyle(
            fontSize: 20,
            color: CustomTheme.getLight() ? Colors.grey : Color(//17
                0xFFEAD8A3),
          ),
        ),
        Text(
          donor.pickupCity,
          style: TextStyle(
            fontSize: 20,
            color: CustomTheme.getLight() ? Colors.grey : Color(//17
                0xFFEAD8A3),
          ),
        ),
      ],
    );
  }

  Widget showPickupTime(BuildContext context) {
    DateFormat dateFormat = DateFormat.yMEd();
    String pickupDate = dateFormat.format(donation.pickupDate);

    return Column(
      children: [
        Text(
          "Pickup on: $pickupDate",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23,
              fontFamily: "BarlowSemiCondensed"),
        ),
        Text(
          "${donation.pickupFromTime.format(context)} - ${donation.pickupToTime.format(context)}",
          style: TextStyle(
            fontSize: 20,
            color: CustomTheme.getLight() ? Colors.grey : Color(0xFFEAD8A3),
          ),
        ),
      ],
    );
  }

  Widget showPackageInfo() {
    return Column(
      children: [
        Text(
          "Other Details:",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23,
              fontFamily: "BarlowSemiCondensed"),
        ),
        Text(
          "Number of Boxes: ${donation.numBoxes}",
          style: TextStyle(
            fontSize: 20,
            color: CustomTheme.getLight() ? Colors.grey : Color(0xFFEAD8A3),
          ),
        ),
        Text(
          "WxHxD: ${donation.width}\" x ${donation.height}\" x ${donation.depth}\"",
          style: TextStyle(
            fontSize: 20,
            color: CustomTheme.getLight() ? Colors.grey : Color(0xFFEAD8A3),
          ),
        ),
        Text(
          "Needs Refrigeration: ${donation.reqFrige ? "Yes" : "No"}",
          style: TextStyle(
            fontSize: 20,
            color: CustomTheme.getLight() ? Colors.grey : Color(0xFFEAD8A3),
          ),
        ),
      ],
    );
  }

  void addToPickups(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser!.uid;

    var donationUpdateData = {
      'pickupVolunteerId': currentUser,
    };

    CollectionReference donations =
        FirebaseFirestore.instance.collection('donations');

    await donations.doc(donation.docId).update(donationUpdateData);
    Navigator.pop(context);
  }

  void updatePickupTime(BuildContext context) async {
    var donationUpdateData = {
      'pickupCompletedAt': FieldValue.serverTimestamp(),
    };

    CollectionReference donations =
        FirebaseFirestore.instance.collection('donations');

    await donations.doc(donation.docId).update(donationUpdateData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup Item: ${donation.name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            ),
            Image(
              image: AssetImage('images/placeholder.jpg'),
              height: 100,
              width: 1000,
            ),
            Padding(padding: EdgeInsets.all(5)),
            showAddress(),
            Padding(padding: EdgeInsets.all(5)),
            showPickupTime(context),
            Padding(padding: EdgeInsets.all(5)),
            showPackageInfo(),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: widgetColor, // Background color
                onPrimary: Colors.black,
              ),
              onPressed: () {
                isBeingPickedUp()
                    ? updatePickupTime(context)
                    : addToPickups(context);
              },
              child:
                  Text(isBeingPickedUp() ? 'Mark as Picked Up' : 'Pick this up',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
