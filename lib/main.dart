import 'package:e_triage/routes.dart';
import 'package:flutter/material.dart';

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
      ],
      child: MaterialApp(
        title: 'COVID 19 Health Declaration Form',
        theme: uermTheme,
        routes: routes,
      ),
    );
  }
}