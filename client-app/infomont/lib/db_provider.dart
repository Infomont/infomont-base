import 'dart:io';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'hike_option.dart';


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    WidgetsFlutterBinding
        .ensureInitialized(); // TODO: figure out why do we need that? Maybe not required when running from inside a widget

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "infomont._database");

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
          join("assets", "_database", "infomont._database"));
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

  Future<List<HikeOption>> getHikeOptions(int id) async {
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
      Where IDDepPoint = (Select ID from Point where name like ?)
      And IDDestPoint = (Select ID from Point where name like ?))
      Order By CacheTrekID, PortionOrder
      )
    ''';

    var result = await db.rawQuery(queryString, ['Complex turistic Sambata', 'Fereastra Mare a Sambetei']);
    return result.isNotEmpty ? result.map((o) => HikeOption.fromJson(o)).toList() : [];
  }
}