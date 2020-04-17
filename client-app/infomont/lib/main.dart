import 'dart:io';
import 'dart:math';
import 'dart:developer' as developer;

import 'package:app/json_adapter.dart';
import 'package:app/result_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'hike_option_provider.dart';
import 'start_page.dart';

import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // TODO: figure out why do we need that? Maybe not required when running from inside a widget

  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "infomont.db");

// Check if the database exists
  var exists = await databaseExists(path);

  if (!exists) {
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "db", "infomont.db"));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);

  } else {
    print("Opening existing database");
  }
// open the database
  var db = await openDatabase(path, readOnly: true);

  developer.log(db.runtimeType.toString());

  runApp(InfoMontApp());
}

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
