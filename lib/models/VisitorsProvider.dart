import 'dart:convert';

import 'package:e_triage/services/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class VisitorsProvider with ChangeNotifier {
  

  saveVisitor(Map form) async {

    String url = mainApi(url: 'etriage/register-visitor');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'LastName': form['lastName'],
        'FirstName': form['firstName'],
        'MiddleInitial': form['middleInitial'],
        'ContactNo': form['contactNo'],
        'Department': form['department'],
        'Remarks': form['remarks'],
      }),
    );

    //getAppointments();
    // notifyListeners();
    //print(response.body);
    
    return json.decode(response.body);
  }

  
}
