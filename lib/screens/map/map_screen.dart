import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ovcapp/assets/ovcicons.dart';
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(OVCIcons.backicon),
            color: Color(0xFFE0CB8F)),
        title: Text(
          'Volunteer Map',
          style: TextStyle(
              fontFamily: 'BigShouldersDisplay',
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE0CB8F)),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(37.466089, -122.156659), zoom: 17.0),
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
