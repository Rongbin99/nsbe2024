// page3.dart
import 'package:client/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'camera.dart';
import 'package:http/http.dart' as http;

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
  String imagePath = "";
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
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
      return Container();
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
                        setState(() {
                          imagePath = image.path;
                        });
                        GallerySaver.saveImage(imagePath);
                      } catch (e) {
                        print(e);
                      }
                      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Camera()));
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
                    try {
                      final image = await controller!.takePicture();
                      image.readAsBytes().then((bytes) => {
                            client.post(
                                Uri.http("localhost:5000", "/upload", {
                                  "id": DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString()
                                }),
                                body: bytes)
                          });
                      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text("Take Photo")),
              TextButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.getImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      imagePath = pickedFile.path;
                    });
                  }
                },
                child: const Text("Pick Image from Gallery"),
              ),
              /*if (imagePath != "")
                Container(
                    width: 300,
                    height: 300,
                    child: Image.file(
                      
                      File(imagePath),
                    ))*/
            ],
          ),
        ),
      ),
    );
  }
}

getPath() {
  return _MyHomePageState().imagePath;
}
