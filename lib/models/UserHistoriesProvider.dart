import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:e_triage/services/Api.dart';
import 'package:http/http.dart' as http;

class UserHistoriesProvider with ChangeNotifier {
  List userHistories = [];


  Future<dynamic> getUserHistories() async {
    final url = mainApi(url: 'etriage/user-histories');
    final response = await http.get(url);

    final userHistoriesData = json.decode(response.body);
    userHistories = userHistoriesData;
  }
}

