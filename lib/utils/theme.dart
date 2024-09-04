import 'package:flutter/material.dart';
class ThemeUtils{
static final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:const  AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black54),
  ),
);

static final darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    foregroundColor: Colors.white,
  ),
  cardTheme: CardTheme(
    color: Colors.grey[800],
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  textTheme:const  TextTheme(
    displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white70),
  ),
);

}