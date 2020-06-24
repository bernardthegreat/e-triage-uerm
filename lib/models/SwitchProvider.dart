import 'package:flutter/material.dart';

class SwitchProvider with ChangeNotifier {

  Map _switchValues = {
    'fever': false,
    'cough_colds': false,
    'difficulty_breathing': false,
    'headache': false,
    'sore_throat': false,
    'joint_pains': false,
    'stomach_ache_diarrhea': false,
    'travel_14_days': false,
    'person_with_travel_history': false,
    'exposure_to_individuals': false,
    'exposure_to_confirmed_case': false,
    'exposed_to_pui': false,
  };

  get switchValues {
    return _switchValues;
  }

}
