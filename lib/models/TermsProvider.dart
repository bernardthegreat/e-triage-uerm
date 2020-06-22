import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_triage/services/Api.dart';

class TermsProvider with ChangeNotifier {
  
  Future<dynamic> getTerms() async {
    try {
      
      final url = mainApi(url: 'terms/e-triage');
      final response = await http.get(url);
      final apiTermData = json.decode(response.body);
      notifyListeners();
      return apiTermData['healthDeclarationPolicy'];
    } catch (error) {
      return {'error': error};
    }
  }
}
