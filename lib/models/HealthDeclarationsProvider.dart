import 'dart:convert';

import 'package:e_triage/services/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HealthDeclarationsProvider with ChangeNotifier {
  saveHealthDeclaration(Map form) async {
    form.remove('accept_terms');
    form.forEach((key, val) {
      if (val == true) {
        _hdfwithSuspectedCovid(form, key);
      }
    });

    var _list = form.values.toList();

    var element = true;

    if (!_list.contains(element)) {
      _hdfNormal(_list);
    }

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
      print(_list);
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
