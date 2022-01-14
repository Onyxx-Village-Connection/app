import 'package:cloud_firestore/cloud_firestore.dart';

class DonorModel {
  String uid;
  String name;
  String? profileImage;
  String phone;
  String city;
  String zip;
  String address;
  var timeStamp;

  DonorModel({
    required this.uid,
    required this.name,
    required this.profileImage,
    required this.phone,
    required this.address,
    required this.city,
    required this.zip,
    required this.timeStamp,
  });

  // data from server parsing
  factory DonorModel.fromMap(map, String uid) {
    return DonorModel(
      uid: uid,
      name: map['name'],
      profileImage: map['profileImage'],
      address: map['address'],
      city: map['city'],
      zip: map['zip'],
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
      'address': address,
      'city': city,
      'zip': zip,
      'timeStamp': FieldValue.serverTimestamp(),
    };
  }
}
