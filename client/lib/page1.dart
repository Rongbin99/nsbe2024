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

void _onMarkerTapped(String assetName) {
  showDialog(
    context: context,
    builder: (context) {
      bool isImage = true;
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isImage = !isImage;
                });
              },
              child: isImage
                  ? Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset(assetName),
                    )
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Your information here',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
            ),
          );
        },
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memories'),
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
                CustomMarker(
                  markerId: MarkerId('UofT'),
                  position: LatLng(43.66069590096232, -79.3964813015131),
                  onTap: () => _onMarkerTapped('assets/images/jim.png'),
                  icon: snapshot.data ?? BitmapDescriptor.defaultMarker,
                  assetName: 'assets/images/jim.png',
                ),
                CustomMarker(
                  markerId: MarkerId('Evan House'),
                  position: LatLng(43.81482894945967, -79.32526497341495),
                  onTap: () => _onMarkerTapped('assets/images/jim.png'),
                  icon: snapshot.data ?? BitmapDescriptor.defaultMarker,
                  assetName: 'assets/images/jim.png',
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

class CustomMarker extends Marker {
  final String assetName;

  CustomMarker({
    required MarkerId markerId,
    required LatLng position,
    required this.assetName,
    BitmapDescriptor? icon,
    VoidCallback? onTap,
  }) : super(
          markerId: markerId,
          position: position,
          // icon: icon,
          onTap: onTap,
        );
}