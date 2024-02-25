import 'package:flutter/material.dart';

Widget _buildGradient() {
  return Positioned.fill(
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.5, 0.95],
        ),
      ),
    ),
  );
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            color: Colors.transparent, // change the color as needed
            child: Stack(
              children: <Widget>[
                _buildGradient(),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0), // adjust the padding as needed
                      child: Align(
                        alignment: Alignment.center, // adjust the alignment as needed
                        child: CircleAvatar(
                          radius: 100, // adjust the size of the image
                          backgroundImage: AssetImage('assets/images/jim.png'), // replace with your image
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white, // change the color as needed
                          fontSize: 24, // change the size as needed
                          fontWeight: FontWeight.bold, // change the weight as needed
                        ),
                      ),
                      subtitle: Text(
                        'This is the profile page!',
                        style: TextStyle(
                          color: Colors.white, // change the color as needed
                          fontSize: 16, // change the size as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}