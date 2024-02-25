import 'package:flutter/material.dart';
import 'page3_lib.dart' as page3;

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: const Text('Image Preview'),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("http://127.0.0.1:5000/static/testimages/${page3.getPath()}"), //change to server URL of image
              fit: BoxFit.cover,                  //you can use this method to get the location of the saved image
            ),                                  //and then send it to the server                          
          ),
        )
      )
    );
  }
}