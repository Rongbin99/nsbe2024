import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  GoogleMapController? mapController;
  final TextEditingController _searchController = TextEditingController();
  Position? _currentPosition;
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _initialcameraposition = LatLng(position.latitude, position.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _searchAddress() async {
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=${_searchController.text}&key=AIzaSyCKjJjrQeYQOdPvrKOr659n1BQmvhE_c4g'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final lat = data['results'][0]['geometry']['location']['lat'];
      final lng = data['results'][0]['geometry']['location']['lng'];
    print(lat);
    print(lng);
      mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(lat, lng),
        ),
      );
    } else {
      print('Failed to load coordinates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Enter Address',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _searchAddress,
            style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            backgroundColor: Colors.blue,
          ),
            child: const Text('Search',
            style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Container(
            height: 10.0,
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialcameraposition,
                zoom: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}