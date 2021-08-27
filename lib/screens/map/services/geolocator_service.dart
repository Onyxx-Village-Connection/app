import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ovcapp/screens/map/map_screen.dart';

class GeolocatorService {
  final Geolocator geo = Geolocator();

  Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high, distanceFilter: 10);
  }

  Future<Position> getInitialLocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

//purpose is to upload volunteer's geolocation to firestore database
//still waiting on volunteer side to be complete before fully implementing
//idea: if volunteer document property "isOnline:true", then stream location
// when "isOnline:false", cancel subscription + clear database idk
