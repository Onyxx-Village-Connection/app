import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ovcapp/screens/map/map_screen.dart';

class GeolocatorService {
  final Geolocator geo = Geolocator();
  Geoflutterfire gff = Geoflutterfire();

  Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.high, distanceFilter: 10);
  }

  Future<Position> getInitialLocation() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

//store each geohash/location of user or just replace the previous one with newest?
//idea: if volunteer document property "isOnline:true", then stream location
// when "isOnline:false", cancel subscription + clear document
