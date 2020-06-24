import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:e_triage/services/Api.dart';
import 'package:http/http.dart' as http;

class SymptomsProvider with ChangeNotifier {
  List _symptoms = [];

  Map _switchValues = {
    'fever': false,
    'cough_colds': false,
    'difficulty_breathing': false,
    'headache': false,
    'sore_throat': false,
    'joint_pains': false,
    'stomach_ache_diarrhea': false,
  };

  get symptoms {
    return _symptoms;
  }

  get switchValues {
    return _switchValues;
  }

  Future<dynamic> getSymptoms() async {
    final url = mainApi(url: 'etriage/symptoms');
    final response = await http.get(url);
    //print(response.body);
    final symptomsData = json.decode(response.body);
    _symptoms = symptomsData;
  }
}
