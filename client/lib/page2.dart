import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';
import 'dart:convert';
import 'user_lib.dart' as user;
import 'package:http/http.dart' as http;

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
  final int _randomValue = Random().nextInt(101); // Define your random value here

  @override
  void initState() {
    super.initState();
    statsFuture = fetchStats();
  }

  Future<Map<String, int>> fetchStats() async {
    final response1 = await http.get(Uri.parse('http://127.0.0.1:5000/getnumposts/${user.getUserID()}'));

    int numposts = jsonDecode(response1.body)["numposts"];

    final response2 = await http.get(Uri.parse('http://127.0.0.1:5000/users/${user.getUserID()}'));

    int score = jsonDecode(response2.body)["Score"];

    return {
      'totalImagesShared': numposts,
      'score': score,
      'mastery': 100 * score ~/ 50,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, int>>(
        future: statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final stats = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0), 
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(18.0),
                          color: Colors.transparent, 
                        ),
                                               
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/01-cn-tower.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              // Add this
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                    0.5), // Adjust opacity as needed
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              )
                            ),
                            _buildGradient(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 100,
                                      backgroundImage:
                                          AssetImage('pfp.jpg'),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: ListTile(
                                    title: Text(
                                      "${user.getName()}'s Mosaic Profile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Text(
                                      'Toronto, ON, Canada',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          const Text(
                                            'Total Mosaics Shared',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            '${stats['totalImagesShared']}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          const Text(
                                            'M-Score',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            '${stats['score']}',
                                            style: const TextStyle(
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
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 40,
                          ),
                          Center(
                            child: Text(
                              'Mosiac Mastery: ${stats['mastery']}%',
                              style: const TextStyle(
                                  decorationColor: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Container(
                            height: 40,
                          ),
                          Center(
                            child: SfRadialGauge(axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  showLabels: false,
                                  showTicks: false,
                                  axisLineStyle: const AxisLineStyle(
                                    thickness: 0.25,
                                    cornerStyle: CornerStyle.bothCurve,
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                      value: stats['mastery']! / 100,
                                      cornerStyle: CornerStyle.bothCurve,
                                      width: 0.25,
                                      color: Colors.blue[100],
                                      sizeUnit: GaugeSizeUnit.factor,
                                    ),
                                    NeedlePointer(
                                      // Add this
                                      value: stats['mastery']! / 100,
                                      needleLength: 0.6,
                                      lengthUnit: GaugeSizeUnit.factor,
                                      needleColor: Colors.black,
                                    ),
                                  ],
                                  annotations: const <GaugeAnnotation>[])
                            ]),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }else {
          return Center(
            child: Image.asset('assets/logo-01.gif'),
          );
        }
        },
      ),
    );
  }
}
