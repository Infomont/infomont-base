import 'package:flutter/material.dart';

const Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

ThemeData buildThemeData() {
  return ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.

    textTheme: TextTheme(
      body1: TextStyle(color: Colors.black),
      body2: TextStyle(color: Colors.black),
      //button: TextStyle(color: Colors.black),
      //caption: TextStyle(color: Colors.indigo),
      display1: TextStyle(color: Colors.black),
      display2: TextStyle(color: Colors.black),
      display3: TextStyle(color: Colors.black),
      display4: TextStyle(color: Colors.black),
      headline: TextStyle(color: Colors.amberAccent),
      subhead: TextStyle(color: Color(0xFFE0E2DB)),
      //title: TextStyle(color: Color(0xFFE0E2DB)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xFEFDD124),
      hoverColor: Colors.red,
      filled: true,
    ),

    cursorColor: Color(0xFF5D576B),
    primarySwatch: MaterialColor(0xFF445B18, color),
    scaffoldBackgroundColor: Colors.lightGreen,
    accentColor: Color(0xFFE0E2DB),
    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
    fontFamily: "Roboto",
    canvasColor: Color(0xFF445B18),
    hintColor: Color(0xFF8884FF),
  );
}