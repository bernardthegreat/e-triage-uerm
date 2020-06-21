import 'package:e_triage/components/RegisterUser.dart';
import 'package:flutter/material.dart';

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
      body: RegisterUser(),
    );
  }
}