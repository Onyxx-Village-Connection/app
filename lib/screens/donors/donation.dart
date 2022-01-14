// model for one donation
import 'package:flutter/material.dart';
import 'dart:io';

class Donation {
  String docId = "";
  String name = "";
  double weight = 0.0;
  int numBoxes = 0;
  int numMeals = 0;
  double width = 0.0;
  double height = 0.0;
  double depth = 0.0;
  bool hasDairy = false;
  bool hasNuts = false;
  bool hasEggs = false;
  bool reqFrige = false;
  bool isGrocery = false;
  DateTime pickupDate = DateTime.now();
  TimeOfDay pickupFromTime = TimeOfDay.now();
  TimeOfDay pickupToTime = TimeOfDay.now();
  DateTime submitDateTime = DateTime.now();
  String userId = "";
  File? itemImg;
  String? itemImgUrl;

  Donation()
      : docId = "",
        name = "",
        weight = 0.0,
        numBoxes = 0,
        numMeals = 0,
        width = 0.0,
        height = 0.0,
        depth = 0.0,
        hasDairy = false,
        hasNuts = false,
        hasEggs = false,
        reqFrige = false,
        isGrocery = false,
        pickupDate = DateTime.now(),
        pickupFromTime = TimeOfDay.now(),
        pickupToTime = TimeOfDay.now(),
        submitDateTime = DateTime.now(),
        userId = "";

  Donation.fromJson(Map<String, dynamic> json)
      : docId = json['docId'] ?? "",
        name = json['name'] ?? "",
        weight = (json['weight']?.runtimeType == String)
            ? double.parse(json['weight'])
            : json['weight'].toDouble(),
        numBoxes = json['numBoxes'] ?? 0,
        numMeals = json['numMeals'] ?? 0,
        width = (json['width']?.runtimeType == String)
            ? double.parse(json['width'])
            : json['width'].toDouble(),
        height = (json['height']?.runtimeType == String)
            ? double.parse(json['height'])
            : json['height'].toDouble(),
        depth = (json['depth']?.runtimeType == String)
            ? double.parse(json['depth'])
            : json['depth'].toDouble(),
        hasDairy = json['hasDairy'] ?? false,
        hasNuts = json['hasNuts'] ?? false,
        hasEggs = json['hasEggs'] ?? false,
        reqFrige = json['reqFrige'] ?? false,
        isGrocery = json['isGrocery'] ?? false,
        pickupDate = DateTime.fromMillisecondsSinceEpoch(json['pickupDate']),
        pickupFromTime = TimeOfDay(
            hour: json['pickupFromTime'] ~/ 60,
            minute: json['pickupFromTime'] % 60),
        pickupToTime = TimeOfDay(
            hour: json['pickupToTime'] ~/ 60,
            minute: json['pickupToTime'] % 60),
        submitDateTime =
            DateTime.fromMillisecondsSinceEpoch(json['submitDateTime']),
        userId = json['userId'] ?? "",
        itemImgUrl = json['itemImgUrl'];

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'weight': weight,
        'numBoxes': numBoxes,
        'numMeals': numMeals,
        'width': width,
        'height': height,
        'depth': depth,
        'hasDairy': hasDairy,
        'hasNuts': hasNuts,
        'hasEggs': hasEggs,
        'reqFrige': reqFrige,
        'isGrocery': isGrocery,
        'pickupDate': pickupDate.millisecondsSinceEpoch,
        'pickupFromTime': pickupFromTime.hour * 60 + pickupFromTime.minute,
        'pickupToTime': pickupToTime.hour * 60 + pickupToTime.minute,
        'submitDateTime': submitDateTime.millisecondsSinceEpoch,
        'userId': userId,
        'itemImgUrl': itemImgUrl,
      };
}
