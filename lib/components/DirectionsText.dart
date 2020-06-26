import 'package:flutter/material.dart';

class DirectionsText extends StatelessWidget {
  final title;
  DirectionsText({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      padding: EdgeInsets.all(20),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
    );
  }
}
