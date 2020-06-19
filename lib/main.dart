import 'package:e_triage/routes.dart';
import 'package:flutter/material.dart';

import 'theme/themedata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'COVID 19 Health Declaration Form',
        theme: uermTheme,
        routes: {
          '/':(_)=>Text('asd'),
        },
    );
  }
}