import 'dart:io';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'hike_option.dart';

// TODO: extract to new file
class Point {
  int id;
  String name;
  String description;

  Point({this.id, this.name, this.description});

  factory Point.fromJson(Map<String, dynamic> data) => new Point(id: data["id"], name:data["name"], description: data["description"],);
  factory Point.fromDatabase(Map<String, dynamic> data) => new Point(id: data["ID"], name:data["Name"], description: data["Description"],);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };

}


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
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
      ByteData data = await rootBundle.load(
          join("assets", "db", "infomont.db"));
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

  Future<List<Point>> getPoints(String searchText) async {
    final db = await database;

    var result = await db.query("Point", columns: ["ID", "Name", "Description"], where: "Name like ?", whereArgs: [searchText], limit: 5);
    return result.isNotEmpty ? result.map((o) => Point.fromDatabase(o)).toList() : [];
  }

  Future<List<HikeOption>> getHikeOptions(String departurePoint, String destinationPoint) async {
    final db = await database;

   final queryString = '''
      Select StartPoint.Name || ' - ' || (Select max(DestinationPoint.Name)) as OptionName, StartPoint.Name as StartPoint, 
      (Select max(DestinationPoint.Name)) as DestinationPoint, (Select group_concat(distinct MarkType.Name)) as Marks,
      group_concat(distinct MarkState.Description) as MarksQuality, Sum(Portion.Duration) as Duration, Portion.Description as ShortDescription from Portion
      Inner Join Point as StartPoint
      On Portion.StartPointID = StartPoint.ID
      Inner Join Point as DestinationPoint
      On Portion.DestinationPointID = DestinationPoint.ID
      Inner Join MarkType
      On Portion.MarkType = MarkType.ID
      Inner Join MarkState
      On Portion.MarkState = MarkState.ID
      where Portion.ID in (
      Select IDPortion from Cache_Trek_Portions
      Where CacheTrekID in (
      Select ID from Cache_Trek 
      Where IDDepPoint = (Select ID from Point where name like '$departurePoint')
      And IDDestPoint = (Select ID from Point where name like '$destinationPoint'))
      Order By CacheTrekID, PortionOrder
      )
    ''';

    var result = await db.rawQuery(queryString);
    return result.isNotEmpty ? result.map((o) => HikeOption.fromDatabase(o)).toList() : [];
  }
}