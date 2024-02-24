import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  GoogleMapController? mapController;

  final LatLng _center = const LatLng(43.66109092011767, -79.3948663993955);
  Future<BitmapDescriptor>? customIconFuture;

  @override
  void initState() {
    super.initState();
    customIconFuture = setCustomMarker();
  }

  Future<BitmapDescriptor> setCustomMarker() async {
    final byteData = await rootBundle.load('assets/images/jim.png');
    final result = await FlutterImageCompress.compressWithList(
      byteData.buffer.asUint8List(),
      minWidth: 50,
      minHeight: 50,
      quality: 100,
    );
    return BitmapDescriptor.fromBytes(result);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

void _onMarkerTapped() {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: 120, // specify the width
          height: 150, // specify the height
          child: Column(
            children: [
              Container(
                width: 100, // specify the width
                height: 100, // specify the height
                child: Image.asset('assets/images/jim.png'),
              ),
              Text('This is a custom marker!'),
            ],
          ),
        ),
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: FutureBuilder<BitmapDescriptor>(
        future: customIconFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('UofT'),
                  position: LatLng(43.66069590096232, -79.3964813015131),
                  onTap: _onMarkerTapped,
                  icon: snapshot.data ?? BitmapDescriptor.defaultMarker,
                ),
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}