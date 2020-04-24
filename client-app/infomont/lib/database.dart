import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';



Future<Database> openInfoMontDatabase() async {
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

  return db;
}