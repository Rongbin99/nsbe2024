// page1.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}
class _Page1State extends State<Page1> {
  GoogleMapController? mapController;

  final LatLng _center = const LatLng(43.66069590096232, -79.3964813015131);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}