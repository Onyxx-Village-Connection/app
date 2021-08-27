import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ovcapp/screens/map/services/geolocator_service.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  final geoService = GeolocatorService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      initialData: null,
      create: (context) => geoService.getInitialLocation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<Position>(
          builder: (context, position, widget) {
            return (position != null)
                ? Map(position)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class Map extends StatefulWidget {
  final Position initialPosition;

  Map(this.initialPosition);

  @override
  State createState() => _MapState();
}

class _MapState extends State {
  final GeolocatorService geoService = GeolocatorService();
  Completer _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(37.466089, -122.156659), zoom: 17.0),
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          padding: EdgeInsets.only(
            top: 40.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
