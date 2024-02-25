import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'user_lib.dart' as user;
import 'page3_lib.dart' as page3;

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  var lat = 0.0;
  var lng = 0.0;
  GoogleMapController? mapController; 
  final TextEditingController _searchController = TextEditingController();
  Position? _currentPosition;
  LatLng _initialcameraposition = LatLng(17.6078, 8.0817);

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
      lat = data['results'][0]['geometry']['location']['lat'];
      lng = data['results'][0]['geometry']['location']['lng'];
      
      mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(lat, lng),
        ),
      );
    } else {
      print('Failed to load coordinates');
    }
  }

  void _confirmAddress() async {
    if (lat != 0.0 || lng != 0.0) {
      await http.get(Uri.parse('http://127.0.0.1:5000/newpost/${user.getUserID()}/${page3.getPath()}/$lat/$lng'));
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
          ElevatedButton(
            onPressed: _confirmAddress,
            child: Text('Confirm'),
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