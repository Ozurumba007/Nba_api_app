import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // get teams
  Future getTeams() async {
    var response = await http.get(
      Uri.http('balldontlie.io', 'api/v1/teams'),
    );
    var jsonData = jsonDecode(response.body);
    for (var eachTeam in jsonData['data']) {}
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
