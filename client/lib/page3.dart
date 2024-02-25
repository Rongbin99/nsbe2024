// page3.dart
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:convert';

import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:image_picker/image_picker.dart';
import 'camera.dart';
import 'package:http/http.dart' as http;

var imagePath = "LASAGNA";

final client = http.Client();

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Camera'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraController? controller;
  //String imagePath = "";
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      cameras = await availableCameras();
    } catch (e) {
      print("cam ded");
      setState(() {});
      return;
    }
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () async {
                      Uint8List? imageData = await ImagePickerWeb.getImageAsBytes();

                      var url = Uri.parse('http://127.0.0.1:5000/upload');
                      var request = http.MultipartRequest('POST', url);
                      request.files.add(http.MultipartFile.fromBytes('image', imageData!, filename: 'image.jpg'));
                      var response = await request.send();
                      if (response.statusCode == 200) {
                        print("Image uploaded");
                        http.Response res = await http.Response.fromStream(response);
                        Map<String, dynamic> responseBody = jsonDecode(res.body);

                        imagePath = responseBody["vidname"];
                        
                        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Camera()));
                      } else {
                        print("Image upload failed");
                      }
                    },
                    child: const Text("Pick Image from Gallery",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20), 
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 500,
                height: 500,
                child: AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final image = await controller!.takePicture();
                      image.readAsBytes().then((bytes) async {
                        var uri = Uri.http("localhost:5000", "/upload", {
                          "id": DateTime.now().millisecondsSinceEpoch.toString()
                        });

                        var request = http.MultipartRequest('POST', uri);
                        request.files.add(http.MultipartFile.fromBytes('image', bytes, filename: 'image.jpg')); // replace 'image.jpg' with your filename

                        var response = await request.send();

                        // if (response.statusCode == 200) {
                        //   print('Upload successful');
                        // } else {
                        //   print('Upload failed');
                        // }
                      });
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Camera()));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text("Take Photo",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20), 
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      imagePath = pickedFile.path;

                      // Create a multipart request
                      var request = http.MultipartRequest('POST', Uri.parse('http://your-server.com/upload'));

                      // Attach the file to the request
                      request.files.add(await http.MultipartFile.fromPath('image', pickedFile.path));

                      // Send the request
                      var response = await request.send();

                      // Check the status code of the response
                      if (response.statusCode == 200) {
                        print('Uploaded successfully');
                      } else {
                        print('Upload failed');
                      }

                      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Camera()));
                    }
                  },
                  child: const Text("Pick Image from Gallery",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20), 
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

getPath() {
  return imagePath;
}
