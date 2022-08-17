import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  String uid;
  String name;
  String? profileImage;
  String phone;
  String city;
  double timeWithOVC;
  var createdAt;

  ClientModel({
    required this.uid,
    required this.name,
    required this.profileImage,
    required this.phone,
    required this.city,
    required this.timeWithOVC,
    required this.createdAt,
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
      createdAt: map['createdAt'],
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
      'createdAt': uid.isEmpty ? FieldValue.serverTimestamp() : createdAt,
    };
  }
}
