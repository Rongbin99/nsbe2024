// main.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'page5.dart';
import 'page6.dart';
import 'user_lib.dart' as user;

final client = http.Client();

class Post {
  String username;
  int id;
  String desc;
  String imagepath;

  Post({required this.username, required this.id, required this.desc, required this.imagepath});
  
  static Future<Post> createFromJson(List<dynamic> raw) async {
    Post post = Post(username: "LASAGNA", id: raw[1], desc: '${raw[3]} ${raw[4]}', imagepath: 'http://127.0.0.1:5000/static/testimages/${raw[2]}');
    await post.updateFromResponse(raw);
    return post;
  }
  
  factory Post.fromJson(List<dynamic> raw) {
    Post post = Post(username: "LASAGNA", id: raw[1], imagepath: 'http://127.0.0.1:5000/static/testimages/${raw[2]}', desc: '${raw[3]} ${raw[4]}');

    post.updateFromResponse(raw);

    return post;
  }

  Future<void> updateFromResponse(raw) async {
    int user = raw[0];
    final responseUser = await http.get(Uri.parse('http://127.0.0.1:5000/users/$user'));
    username = jsonDecode(responseUser.body)["Name"];
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(user.getUserID());
    const title = 'Mosaic';

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 27, 108, 155),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                child: null,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Builder(
                builder: (context) =>
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),),
              Builder(
                builder: (context) =>
              ListTile(
                title: const Text('geoTemp'),
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Page6()));
                },
              ),),
              (user.getUserID() != -1) ?
                Builder(
                  builder: (context) => 
                ListTile(
                  title: const Text('Memories'),
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
                  },
                ),) :
                Container(),
              (user.getUserID() != -1) ?
                Builder(
                  builder: (context) =>
                ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page2()));
                  }
                ),) :
        
                Container(),
              (user.getUserID() != -1) ?
                Builder(
                  builder: (context) =>
                ListTile(
                  title: const Text('Leaderboard'),
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page5()));
                  },
                ),) :
                
                Container(),
              (user.getUserID() != -1) ?
                Builder(
                  builder: (context) =>
                ListTile(
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page3()));
                  },
                ),) :
                Container(),
              (user.getUserID() != -1) ? 
                Builder(
                  builder: (context) =>
                ListTile(
                  title: const Text('Sign Out'),
                  onTap: () {
                    user.setName("");
                    user.setUserID(-1);
                    setState(() {});
                  },
                ),) :
                
                Builder(
                  builder: (context) =>
                ListTile(
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page4())).then((value) {
                      setState(() {});
                    });
                    
                  },
                ),),
            ],
          ),
        ),
        body: const Center(
          child: Timeline(),
        ),
      ),
    );
  }
}

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Post> posts = [];
  Future<List<Post>>? _fut;

  Future<List<Post>> _getResults() async {
    http.Response res = await client.get(
        Uri(scheme: "http", host: "127.0.0.1", port: 5000, path: "/feed"));
    if (res.statusCode != 200) throw "netfail: ${res.statusCode}";
    
    List<Post> posts = [];
    for (var item in jsonDecode(res.body)) {
      var post = await Post.createFromJson(item as List<dynamic>);
      posts.add(post);
    }
    return posts;
  }

  @override
  void initState() {
    super.initState();
    _fut = _getResults();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fut,
      initialData: const <Post>[],
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData) {
          var posts = snapshot.data!;
          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final post in posts)
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 600),
                      child: LocationListItem(imagepath: post.imagepath, username: post.username, desc: post.desc)
                    ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          print(snapshot.stackTrace);
          return Text(snapshot.error.toString());
        } else {
          return const Text("Loading");
        }
      },
    );
  }
}

class LocationListItem extends StatelessWidget {
  LocationListItem({
    super.key,
    required this.imagepath,
    required this.username,
    required this.desc,
  });

  final String imagepath;
  final String username;
  final String desc;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              Image.network(
                imagepath,
                key: _backgroundImageKey,
                fit: BoxFit.cover,
              ),
              _buildGradient(),
              _buildTitleAndSubtitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.5, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 25,
      bottom: 25,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            desc,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}

const urlPrefix = '/assets/images/';
