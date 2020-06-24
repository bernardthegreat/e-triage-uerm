import 'package:e_triage/routes.dart';
import 'package:flutter/material.dart';

import 'models/SwitchProvider.dart';
import 'models/SymptomsProvider.dart';
import 'models/UserHistoriesProvider.dart';
import 'models/VisitorsProvider.dart';
import 'theme/themedata.dart';
import 'models/TermsProvider.dart';
import 'models/EmployeesProvider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TermsProvider>(
          create: (context) => TermsProvider(),
        ),

        ChangeNotifierProvider<EmployeesProvider>(
          create: (context) => EmployeesProvider(),
        ),

        ChangeNotifierProvider<VisitorsProvider>(
          create: (context) => VisitorsProvider(),
        ),

        ChangeNotifierProvider<UserHistoriesProvider>(
          create: (context) => UserHistoriesProvider(),
        ),

        ChangeNotifierProvider<SymptomsProvider>(
          create: (context) => SymptomsProvider(),
        ),

        ChangeNotifierProvider<SwitchProvider>(
          create: (context) => SwitchProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'COVID 19 Health Declaration Form',
        theme: uermTheme,
        routes: routes,
      ),
    );
  }
}