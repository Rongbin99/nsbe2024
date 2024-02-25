import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Page5 extends StatefulWidget {
  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  List<List<dynamic>> leaderboardData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/leaderboard/0'));

    if (response.statusCode == 200) {
      setState(() {
        leaderboardData = List<List<dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load leaderboard data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: ListView.builder(
        itemCount: leaderboardData.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('${index + 1}'),
            title: Text(leaderboardData[index][1]),
            trailing: Text(leaderboardData[index][2].toString()),
          );
        },
      ),
    );
  }
}