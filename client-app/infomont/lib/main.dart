import 'package:flutter/material.dart';

import 'start_page.dart';

void main() => runApp(InfoMontApp());

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

class InfoMontApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfoMont Hiking App',
      theme: ThemeData(
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
          scaffoldBackgroundColor: Color(0xFF5D5726),
          accentColor: Color(0xFFE0E2DB),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          fontFamily: "Roboto",
          canvasColor: Color(0xFF445B18),
          hintColor: Color(0xFF8884FF),






      ) ,
      //home: StartPage(title: 'Start Hiking'),
      showSemanticsDebugger: false, // can be used to debug layout or UI issues
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the StartPage widget.
        '/': (context) => StartPage(title: 'Start Hiking with Infomont')
      },
    );
  }
}
