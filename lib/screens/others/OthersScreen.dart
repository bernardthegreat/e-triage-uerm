import 'package:flutter/material.dart';
import 'package:e_triage/components/DashboardSelection.dart';

class OthersScreen extends StatelessWidget {
  const OthersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Others'),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: DashboardSelection(),
    );
  }
}
