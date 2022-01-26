import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import '../../screens/client/client_home_tabs.dart';
import '../../screens/donors/my_donations.dart';
import '../../screens/volunteer/volunteer_home_tabs.dart';

String? nameValidator(value) {
  if (value == null || value.isEmpty || value.length < 2) {
    return 'Please enter your name';
  }
  return null;
}

String? itemNameValidator(value) {
  if (value == null || value.isEmpty || value.length < 2) {
    return 'Please enter the item name';
  }
  return null;
}

String? addressValidator(value) {
  if (value == null || value.isEmpty || value.length < 2) {
    return 'Please enter a valid street address';
  }
  return null;
}

String? zipValidator(value) {
  final zipRegExp = RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$');

  if (value == null || value.isEmpty || !zipRegExp.hasMatch(value)) {
    return 'Please enter a valid zip';
  }
  return null;
}

String? cityValidator(value) {
  if (value == null || value.isEmpty || value.length < 2) {
    return 'Please enter your city';
  }
  return null;
}

String? timeWithOVCValidator(value) {
  if (value == null || value.isEmpty || value.length < 2) {
    return 'Please enter how long you have been with OVC';
  }
  return null;
}

String? doubleValueValidator(value) {
  if (value == null || double.tryParse(value) == null) {
    return 'Please enter a numeric/decimal value';
  }
  return null;
}

String? intValueValidator(value) {
  if (value == null || int.tryParse(value) == null) {
    return 'Please enter a numeric value';
  }
  return null;
}

Future<String?> uploadImgAndGetUrl(
    firebase_storage.Reference storageRef, File file) async {
  var uploadTask = storageRef.putFile(file);
  String? uploadedFileUrl;
  try {
    // Storage tasks function as a Delegating Future so we can await them.
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    uploadedFileUrl = await taskSnapshot.ref.getDownloadURL();
  } on FirebaseException catch (e) {
    // Error while uploading
    print('Error occurred while uploading: $e.code');
  }
  return uploadedFileUrl;
}

Future<String?> uploadItemImage(File imgFile, String docId) async {
  firebase_storage.Reference storageRef = firebase_storage
      .FirebaseStorage.instance
      .ref()
      .child('itemImages')
      .child(docId + '.jpg');

  return await uploadImgAndGetUrl(storageRef, imgFile);
}

Future<String?> uploadProfileImage(File profileImgFile) async {
  firebase_storage.Reference profileStorageRef = firebase_storage
      .FirebaseStorage.instance
      .ref()
      .child('profileImages')
      .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');

  return await uploadImgAndGetUrl(profileStorageRef, profileImgFile);
}

void pushRoleBasedLandingPage(BuildContext context, String role) {
  Widget landingPage = getLandingPage(role);

  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => landingPage));
}

Widget getLandingPage(String role) {
  switch (role) {
    case 'Client':
      return ClientHomeTabBarScreen();

    case 'Donor':
      return MyDonations();

    case 'Volunteer':
      return VolunteerHomeTabBarScreen();

    default:
      return Text('Unknown User Role');
  }
}

Future<String> getUserRole(String uid) async {
  var userDoc =
      await FirebaseFirestore.instance.collection("users").doc(uid).get();
  return userDoc['role'][0];
}

Future<Widget> getRoleBasedLandingPage(String uid) async {
  String userRole = await getUserRole(uid);
  return getLandingPage(userRole);
}
