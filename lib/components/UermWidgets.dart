// import 'package:e_patient_portal/models/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ContainerAlertInfo extends StatelessWidget {
  final Widget child;
  ContainerAlertInfo({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue[300],
          width: 1,
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: child,
    );
  }
}

class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  AdaptiveContainer({this.child});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    return Container(
      padding: mediaQuery.orientation == Orientation.portrait
          ? EdgeInsets.symmetric(horizontal: 20)
          : EdgeInsets.symmetric(horizontal: size.width * .2),
      child: child,
    );
  }
}