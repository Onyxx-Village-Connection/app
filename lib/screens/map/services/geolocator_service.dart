import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

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
