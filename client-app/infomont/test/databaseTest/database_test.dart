import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
/*
// Open the database and store the reference.
Future<Database> setupDB() async {
  /*
  var databasePath = await getDatabasesPath();
  debugPrint('Database path in test: ' +
      databasePath);

   */
  //final Directory documentsDirectory = await getApplicationDocumentsDirectory();
  final Future<Database> database = openDatabase(
    //String path = join(documentsDirectory.path, "infomont.db");
    //var infomontDatabase = await openDatabase(path, version:1, onCreate: _onCreate);
    // return infomontDatabase;
    join('.', 'test', 'database', 'infomont.db'),
    onCreate: (db, version) {
      return db.execute(
        "",
      );
    },
    version: 1,
  );

  return database;
}
*/
void main() {
  test('ignored - test db', () async {
    /*
    TestWidgetsFlutterBinding.ensureInitialized();
    // Setup
    // Recreate the database to the initial state
    var database = await setupDB();

    expect(Database, database.runtimeType);
    // Teardown
    // Stop current executing flows (closing connections, ...)
    // Recreate the database to the initial state

    // expect(result, actual);
    */
  });
}
