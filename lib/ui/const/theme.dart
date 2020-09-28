import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  accentColor: Color(0xFF212529),
  scaffoldBackgroundColor: Color(0xFFe8ecef),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Color(0xFF212529), fontSize: 18),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Color(0xFF212529),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFF212529),
    ),
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xFF212529),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Color(0xFFe8ecef),
      ),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
