import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_api_app/model/team.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<Team> teams = [];

  // get teams
  Future getTeams() async {
    var response = await http.get(
      Uri.http('balldontlie.io', 'api/v1/teams'),
    );
    var jsonData = jsonDecode(response.body);
    for (var eachTeam in jsonData['data']) {
      final team = Team(
        fullName: eachTeam['full_name'],
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
      );
      teams.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'NBA TEAMS',
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder(
        future: getTeams(),
        builder: (context, snapshot) {
          // is it done loading? then show team data
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: ListTile(
                      title: Text(teams[index].fullName),
                      subtitle: Text(teams[index].city),
                      trailing: Text(teams[index].abbreviation),
                    ),
                  ),
                );
              },
            );
          }

          // if it's still loading, show loading circle
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
