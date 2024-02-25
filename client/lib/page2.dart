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

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Future<Map<String, int>>? statsFuture;

  @override
  void initState() {
    super.initState();
    statsFuture = fetchStats();
  }

  Future<Map<String, int>> fetchStats() async {
    // Replace this with your actual backend call
    await Future.delayed(Duration(seconds: 1));
    return {
      'totalImagesShared': 10,
      'score': 85,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
<<<<<<< HEAD
      body: FutureBuilder<Map<String, int>>(
        future: statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final stats = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Card(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      _buildGradient(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: AssetImage('assets/images/jim.png'),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Hi :)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Total Images Shared',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${stats['totalImagesShared']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Score',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '${stats['score']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
=======
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
>>>>>>> cf15c4c670f9afd919ac805c2527f039dde7ee34
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}