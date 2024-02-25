import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';

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
    // Replace this with your actual backend call
    await Future.delayed(const Duration(seconds: 1));
    return {
      'totalImagesShared': 10,
      'score': 85,
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
                      Card(
                        color: Colors.transparent,                        
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
                                color: Colors.black.withOpacity(
                                    0.5), // Adjust opacity as needed
                              ),
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
                                const Center(
                                  child: ListTile(
                                    title: Text(
                                      "Willie's GoMommy Profile",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Text(
                                      'I prefer GoDaddy, but I also love GoMommy.',
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
                                            'Total Images Shared',
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
                                            'Score',
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
                              'GoMommy XP: $_randomValue%',
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
                                      value: _randomValue.toDouble(),
                                      cornerStyle: CornerStyle.bothCurve,
                                      width: 0.25,
                                      color: Colors.blue[100],
                                      sizeUnit: GaugeSizeUnit.factor,
                                    ),
                                    NeedlePointer(
                                      // Add this
                                      value: _randomValue.toDouble(),
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
