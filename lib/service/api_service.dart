import 'dart:convert';

import 'package:my_app/models/github_issues.dart';
import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:my_app/Screens/Login/login_screen.dart';
// import 'package:flutter_auth/Tokener.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/models/labelGithub.dart';

class api_service {
  //fetching for per page with max 30 elements !!!
  Future<List<DataListFromGitIssues>> fetchDataGithubIssues(var page) async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues?page=$page'));

    print("page nor " + page.toString());

    if (response.statusCode == 200) {
      print(response.body);
      return dataListFromGitIssuesFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  //fetching for all the LabelGithub available in flutter repo!!!

  Future<List<String>> fetchDataLabelGithub(var page) async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/flutter/flutter/labels?per_page=100&page=$page'));

    print("page lable " + response.body);
    List<String> stringList = [];
    if (response.statusCode == 200) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      for (var eachteam in jsondata) {
        stringList.add(eachteam['name']);
      }
      return stringList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
