import 'package:flutter/material.dart';

ThemeData uermTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.blueAccent,
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 18
      ),
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.blue,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    textTheme: ButtonTextTheme.primary,
  ),
  // textTheme: TextTheme(
  //   bodyText1: TextStyle(color: Colors.blue),
  // ),
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
