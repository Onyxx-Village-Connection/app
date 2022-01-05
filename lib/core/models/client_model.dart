import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  String uid;
  String name;
  String profileImage;
  String phone;
  String city;
  String timeWithOVC;
  var timeStamp;

  ClientModel({
    required this.uid,
    required this.name,
    required this.profileImage,
    required this.phone,
    required this.city,
    required this.timeWithOVC,
    required this.timeStamp,
  });

  // data from server parsing
  factory ClientModel.fromMap(map, String uid) {
    return ClientModel(
      uid: uid,
      name: map['name'],
      profileImage: map['profileImage'],
      city: map['city'],
      phone: map['phone'],
      timeWithOVC: map['timeWithOVC'],
      timeStamp: map['timeStamp'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileImage': profileImage,
      'phone': phone,
      'city': city,
      'timeWithOVC': timeWithOVC,
      'timeStamp': FieldValue.serverTimestamp(),
    };
  }
}
