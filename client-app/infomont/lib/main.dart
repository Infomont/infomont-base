import 'package:app/db/abstract_db_provider.dart';
import 'package:flutter/material.dart';

import 'db/db_provider.dart';
import 'infomont_theme.dart';
import 'pages/start_page.dart';

void main() => {
  runApp(InfoMontApp(dbProvider: DBProvider()))
};

class InfoMontApp extends StatelessWidget {
  final IDBProvider dbProvider;
  InfoMontApp({this.dbProvider});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfoMont Hiking App',
      theme: buildThemeData(),
      //home: StartPage(title: 'Start Hiking'),
      showSemanticsDebugger: false, // can be used to debug layout or UI issues
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the StartPage widget.
        '/': (context) => StartPage(
          title: 'Start Hiking with Infomont',
          dbProvider: dbProvider,
        )
      },
    );
  }
}