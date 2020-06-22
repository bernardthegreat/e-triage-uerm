import 'package:e_triage/screens/DashboardScreen.dart';
import 'package:e_triage/screens/employees/EmployeeScreen.dart';
import 'package:e_triage/screens/others/OthersScreen.dart';
import 'package:e_triage/screens/visitors/VisitorScreen.dart';
import 'package:flutter/material.dart';

import 'package:e_triage/screens/qr_code/scan.dart';
import 'package:e_triage/screens/qr_code/show.dart';
import 'package:flutter/widgets.dart';

import 'components/MainHealthDeclarationStepper.dart';
import 'components/Terms.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => DashboardScreen(),
  "/employees": (BuildContext context) => EmployeeScreen(),
  "/health_declaration_form": (BuildContext context) => MainHealthDeclarationStepper(),
  "/visitors": (BuildContext context) => VisitorScreen(),
  "/others": (BuildContext context) => OthersScreen(),
  "/scanqr": (BuildContext context) => ScanPage(),
  "/showqr": (BuildContext context) => ShowQR(),
  "/test_api": (BuildContext context) => Terms(),
};
