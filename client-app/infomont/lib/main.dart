import 'package:app/json_adapter.dart';
import 'package:app/result_page.dart';
import 'package:flutter/material.dart';

import 'hike_option_provider.dart';
import 'start_page.dart';

void main() => runApp(InfoMontApp());

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
        primarySwatch: Colors.blue,
      ),
      //home: StartPage(title: 'Start Hiking'),
      showSemanticsDebugger: false, // can be used to debug layout or UI issues
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the StartPage widget.
        '/': (context) => StartPage(title: 'Start Hiking'),
        // When navigating to the "/result" route, build the ResultPage widget.
        '/result': (context) => ResultPage(
            hikeOptionProvider: HikeOptionProvider(JsonAdapter()),
            title: 'Results'),
      },
    );
  }


}
