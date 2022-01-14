import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerModel {
  String uid;
  String name;
  String? profileImage;
  String phone;
  var timeStamp;

  VolunteerModel({
    required this.uid,
    required this.name,
    required this.profileImage,
    required this.phone,
    required this.timeStamp,
  });

  // data from server parsing
  factory VolunteerModel.fromMap(map, String uid) {
    return VolunteerModel(
      uid: uid,
      name: map['name'],
      profileImage: map['profileImage'],
      phone: map['phone'],
      timeStamp: map['timeStamp'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileImage': profileImage,
      'phone': phone,
      'timeStamp': FieldValue.serverTimestamp(),
    };
  }
}
