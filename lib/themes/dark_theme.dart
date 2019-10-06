import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  backgroundColor: Colors.grey[700],
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey[600],
  primaryColorLight: Colors.grey[500],
  primaryColorDark: Colors.grey[800],
  fontFamily: 'Raleway',
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 35.0,
      color: Colors.grey[400],
    ),
    display2: TextStyle(
      fontSize: 50.0,
      color: Colors.grey[400],
    ),
    subhead: TextStyle(
      fontSize: 20.0,
      color: Colors.grey[400],
    ),
    caption: TextStyle(
      fontSize: 15.0,
      color: Colors.grey[400],
    ),
  ),
);
