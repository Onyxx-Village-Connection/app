// 'Donor Profile' screen

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ovcapp/screens/donors/donor.dart';

class DonorProfile extends StatefulWidget {
  const DonorProfile({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  _DonorProfileState createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  // global form key
  final _formKey = GlobalKey<FormState>();

  // form fields
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final firestoreInstance = FirebaseFirestore.instance;

  void getDonor() async {
    await firestoreInstance
        .collection('donors')
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        // new donor profile
      } else {
        // existing donor profile
        var donorProfile = value.docs[0].data();
        _nameController.text = donorProfile["name"];
        _addressController.text = donorProfile["address"];
        _phoneController.text = donorProfile["phone"];
        _emailController.text = donorProfile["email"];
      }
    });
    return;
  }

  void updateDonor(Donor donor) async {
    await firestoreInstance
        .collection('donors')
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        // add new donor
        firestoreInstance.collection("donors").add(donor.toJson());
      } else {
        // update existing donor
        value.docs.forEach((element) {
          firestoreInstance
              .collection("donors")
              .doc(element.id)
              .update(donor.toJson());
        });
      }
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    getDonor();
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Profile'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // avoid overflow when keyboard is shown
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _donorProfileField(_nameController, 'Donor name', 'Donor name'),
              _donorProfileField(
                  _addressController, 'Donor address', 'Donor address'),
              _donorProfileField(
                  _phoneController, 'Donor phone number', 'Donor phone number'),
              _donorProfileField(
                  _emailController, 'Donor email', 'Donor email'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveDonorProfile(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _donorProfileField(
      TextEditingController controller, String label, String hint,
      [bool nextFocus = true]) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        onEditingComplete: () => nextFocus
            ? FocusScope.of(context).nextFocus()
            : FocusScope.of(context).unfocus(),
        validator: (text) => (text != null && text.isEmpty) ? hint : null,
      ),
    );
  }

  void _saveDonorProfile(BuildContext context) {
    final form = _formKey.currentState;
    if (form != null && !form.validate()) {
      return;
    }

    var donor = Donor();
    donor.name = _nameController.text;
    donor.address = _addressController.text;
    donor.phone = _phoneController.text;
    donor.email = _emailController.text;
    donor.userId = userId;

    updateDonor(donor);
    Navigator.pop(context);
  }
}
