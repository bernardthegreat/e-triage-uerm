import 'package:e_triage/screens/DashboardScreen.dart';
import 'package:e_triage/screens/employees/EmployeeScreen.dart';
import 'package:e_triage/screens/others/OthersScreen.dart';
import 'package:e_triage/screens/visitors/VisitorScreen.dart';
import 'package:flutter/material.dart';

import 'package:e_triage/screens/qr_code/scan.dart';
import 'package:e_triage/screens/qr_code/show.dart';
import 'package:flutter/widgets.dart';

import 'components/Help.dart';
import 'components/MainHealthDeclarationStepper.dart';
import 'components/PostRegistration.dart';
import 'components/StepperWithRegistration.dart';
import 'components/UserSearch.dart';
import 'components/UserRegister.dart';
import 'components/test.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => DashboardScreen(),
  "/help": (BuildContext context) => Help(),
  "/employees": (BuildContext context) => EmployeeScreen(),
  "/health_declaration_form": (BuildContext context) => MainHealthDeclarationStepper(),
  "/visitors": (BuildContext context) => VisitorScreen(),
  "/others": (BuildContext context) => OthersScreen(),
  "/scanqr": (BuildContext context) => ScanPage(),
  "/showqr": (BuildContext context) => ShowQR(),
  "/search": (BuildContext context) => UserSearch(),
  "/register": (BuildContext context) => UserRegister(),
  "/post_registration": (BuildContext context) => PostRegistration(),
  
  
  "/stepper_registration": (BuildContext context) => TestHDFForm(),
  "/test_api": (BuildContext context) => TestApp(),
};
