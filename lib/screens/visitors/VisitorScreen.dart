import 'package:flutter/material.dart';
import 'package:e_triage/components/DashboardSelection.dart';

class VisitorScreen extends StatelessWidget {
  const VisitorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitors'),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: DashboardSelection(),
    );
  }
}
