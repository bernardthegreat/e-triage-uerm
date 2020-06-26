import 'dart:convert';

import 'package:e_triage/services/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HealthDeclarationsProvider with ChangeNotifier {
  Future<Map> saveHealthDeclaration(Map form) async {
    bool _isForCovidEr = false;
    List _symptoms = [];
    Map newForm = {};
    form.forEach((key, value) {
      switch(key){
        case 'temp':
          if(double.parse(value) > 37.7){
            _isForCovidEr = true;
          }
          break;
        case 'fever':
        case 'cough_colds':
        case 'difficulty_breathin':
        case 'headache':
        case 'sore_throat':
        case 'joint_pains':
        case 'stomach_ache_diarrhea':
        case 'sense_of_smell_taste':
        case 'travel_14_days':
        case 'person_with_travel_history':
        case 'exposure_to_individuals':
        case 'exposure_to_confirmed_case':
        case 'exposed_to_pui':
          if(value.toString() == 'true'){
            _isForCovidEr = true;
            _symptoms.add(key);
          }
          break;
      }
    });
    newForm['symptoms'] = _symptoms.join(';');
    newForm['code'] = form['code'];
    newForm['temperature'] = form['temp'];
    final String url = mainApi(url: 'etriage/save-health-declaration');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Code': newForm['code'],
        'SymptomAndHistory_Code': newForm['symptoms'],
        'Temperature': newForm['temperature']
      }),
    );
    Map responseJson = json.decode(response.body);
    responseJson['isForCovidEr'] = _isForCovidEr;

    return responseJson;

    // form.remove('accept_terms');
    // form.forEach((key, val) {
    //   if (val == true) {
    //     _hdfwithSuspectedCovid(form, key);
    //   }
    // });

    // var _list = form.values.toList();

    // var element = true;

    // if (!_list.contains(element)) {
    //   _hdfNormal(_list);
    // }

  }

  _hdfwithSuspectedCovid(form, key) {
    final DateTime now = new DateTime.now();
    final DateTime date =
        new DateTime(now.year, now.month, now.day);

    final String url = mainApi(url: 'etriage/save-health-declaration');
    final response = http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'Code': form['code'],
        'SymptomAndHistory_Code': key,
        'Temperature': form['temp'],
        'DateDeclared': date.toString(),
      }),
    );
  }

  _hdfNormal(_list) {

    final DateTime now = new DateTime.now();
      final DateTime date =
          new DateTime(now.year, now.month, now.day);
      
      final String url = mainApi(url: 'etriage/save-health-declaration');
      final response = http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'Code': _list[14],
          'SymptomAndHistory_Code': '',
          'Temperature': _list[13],
          'DateDeclared': date.toString(),
        }),
      );
  }

 
}
