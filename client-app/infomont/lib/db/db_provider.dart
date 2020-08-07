import 'dart:io';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:app/entities/infomont_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/hike_option.dart';
import '../entities/portion_detail.dart';
import '../entities/point.dart';
import 'abstract_db_provider.dart';

class DBProvider implements IDBProvider {
  DBProvider();

  Database _database;

  Future<Database> get database async { // TODO: make sure to cache the Database, if it's not cached yet
    WidgetsFlutterBinding
        .ensureInitialized(); // TODO: figure out why do we need that? Maybe not required when running from inside a widget

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
      ByteData data =
          await rootBundle.load(join("assets", "db", "infomont.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    // open the database
    _database = await openDatabase(path, readOnly: true);

    developer.log(_database.runtimeType.toString());

    return _database;
  }
}
