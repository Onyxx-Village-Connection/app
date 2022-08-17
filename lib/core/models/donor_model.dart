import 'package:cloud_firestore/cloud_firestore.dart';

class DonorModel {
  String uid;
  String orgName;
  String? profileImage;
  String corpPhone;
  String corpCity;
  String corpZip;
  String corpAddress;
  String contactName;
  String contactPhone;
  String pickupCity;
  String pickupZip;
  String pickupAddress;
  var createdAt;

  DonorModel({
    required this.uid,
    required this.orgName,
    required this.profileImage,
    required this.corpPhone,
    required this.corpAddress,
    required this.corpCity,
    required this.corpZip,
    required this.contactName,
    required this.contactPhone,
    required this.pickupAddress,
    required this.pickupCity,
    required this.pickupZip,
    this.createdAt,
  });

  // data from server parsing
  factory DonorModel.fromMap(map, String uid) {
    return DonorModel(
      uid: uid,
      orgName: map['orgName'],
      profileImage: map['profileImage'],
      corpAddress: map['corpAddress'],
      corpCity: map['corpCity'],
      corpZip: map['corpZip'],
      corpPhone: map['corpPhone'],
      contactName: map['contactName'],
      pickupAddress: map['pickupAddress'],
      pickupCity: map['pickupCity'],
      pickupZip: map['pickupZip'],
      contactPhone: map['contactPhone'],
      createdAt: map['createdAt'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'orgName': orgName,
      'profileImage': profileImage,
      'corpPhone': corpPhone,
      'corpAddress': corpAddress,
      'corpCity': corpCity,
      'corpZip': corpZip,
      'contactName': contactName,
      'contactPhone': contactPhone,
      'pickupAddress': pickupAddress,
      'pickupCity': pickupCity,
      'pickupZip': pickupZip,
      'createdAt': uid.isEmpty ? FieldValue.serverTimestamp() : createdAt,
    };
  }
}
