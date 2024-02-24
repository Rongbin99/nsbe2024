// main.dart
import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'GoMommy';
    const title2 = 'insert';

    return MaterialApp(
      title: title,
      home: Builder( // add this
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Page 1'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
                  },
                ),
                ListTile(
                  title: Text('Page 2'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page2()));
                  },
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text(title2),
                floating: true,
                flexibleSpace: Placeholder(),
                expandedHeight: 200,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(title: Text('Item #$index')),
                  childCount: 1000,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}