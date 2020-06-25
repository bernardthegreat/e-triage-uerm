import 'dart:convert';

import 'package:e_triage/services/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmployeesProvider with ChangeNotifier {
  List employee = [];

  List existingHDF = [];

  Future<Map> searchEmployee({String code}) async {
    try {
      if (!isSearchEmployeeByCode(code)) {
        employee = await searchByEmployeeName(code);
      } else {
        employee = await searchByEmployeeCode(code);
      }

      notifyListeners();

      return {'success': 'Employee Found!'};
    } catch (error) {
      return {'error': error};
    }
  }

  void clearEmployee() {
    employee = [];
    notifyListeners();
  }

  bool isSearchEmployeeByCode(String code) {
    final numberRegEx = RegExp(r"[0-9]");
    if (!numberRegEx.hasMatch(code)) {
      return false;
    } else
      return true;
  }

  bool isSearchEmployeeByName(String code) {
    final nameRegEx = RegExp(r"[A-Z]");
    if (!nameRegEx.hasMatch(code)) {
      return false;
    } else
      return true;
  }

  Future<List> searchByEmployeeCode(String code) async {
    final url = mainApi(url: 'employees/search/code', params: '&code=$code');
    final response = await http.get(url);

    _getExistingHDF(code);

    final response_json = json.decode(response.body);
    return response_json['result'];
  }

  Future<List> searchByEmployeeName(String code) async {
    final url = mainApi(url: 'employees/search/name', params: '&name=$code');
    final response = await http.get(url);
    final response_json = json.decode(response.body);
    return response_json['result'];
  }

  _getExistingHDF(String code) async {
    final url = mainApi(url: 'etriage/get-hdf', params: '&UserCode=$code');
    final response = await http.get(url);

    final responseBody = json.decode(response.body);
    return responseBody;
  }
}
