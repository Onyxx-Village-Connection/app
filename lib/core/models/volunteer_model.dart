import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerModel {
  String uid;
  String name;
  String? profileImage;
  String phone;
  String availability;
  String volunteerStmt;
  String languages;
  String tasks;
  var createdAt;

  VolunteerModel({
    required this.uid,
    required this.name,
    required this.profileImage,
    required this.phone,
    required this.availability,
    required this.volunteerStmt,
    required this.languages,
    required this.tasks,
    required this.createdAt,
  });

  // data from server parsing
  factory VolunteerModel.fromMap(map, String uid) {
    return VolunteerModel(
      uid: uid,
      name: map['name'],
      profileImage: map['profileImage'],
      phone: map['phone'],
      languages: map['languages'],
      tasks: map['tasks'],
      availability: map['availability'],
      volunteerStmt: map['volunteerStmt'],
      createdAt: map['createdAt'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileImage': profileImage,
      'phone': phone,
      'languages': languages,
      'tasks': tasks,
      'availability': availability,
      'volunteerStmt': volunteerStmt,
      'createdAt': uid.isEmpty ? FieldValue.serverTimestamp() : createdAt,
    };
  }
}
