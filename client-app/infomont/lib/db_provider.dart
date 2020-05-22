import 'dart:io';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'hike_option.dart';
import 'portion_detail.dart';
import 'point.dart';

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

  Future<List<HikeOption>> getHikeOptions(int departurePointId, int destinationPointId) async {
    List<HikeOption> hikeOptions = new List<HikeOption>();

    List<PortionDetail> portionDetails =  await  getPortionDetails(departurePointId, destinationPointId);

    var portionDetailsByTrackId = new Map<int, List<PortionDetail>>();

    if(portionDetails.length == 0)
      return hikeOptions;

    for (var portionDetail in portionDetails) {
      if (!portionDetailsByTrackId.containsKey(portionDetail.cacheTrekId)) {
        portionDetailsByTrackId[portionDetail.cacheTrekId] = new List<PortionDetail>();
      }

      portionDetailsByTrackId[portionDetail.cacheTrekId].add(portionDetail);
    }


    for (var entry in portionDetailsByTrackId.entries) {
      var currentTrackPortionDetails = entry.value;
      
      int durationSum = 0;
      var notDuplicatedMarks = new Set<String>();
      var notDuplicatedMarkStates = new Set<String>();
      for (var portionDetail in currentTrackPortionDetails) {
        durationSum += portionDetail.duration;
        notDuplicatedMarks.add(portionDetail.mark);
        notDuplicatedMarkStates.add(portionDetail.markState);
      }

      HikeOption hikeOption = new HikeOption();
      hikeOption.optionName = currentTrackPortionDetails[0].startPointName + ' - ' + currentTrackPortionDetails[currentTrackPortionDetails.length -1 ].destinationPointName;
      hikeOption.duration = 0;
      hikeOption.shortDescription = currentTrackPortionDetails[0].description;
      hikeOption.duration = getTimeString(durationSum);
      hikeOption.marks = notDuplicatedMarks.join(', ');
      hikeOption.marksQuality = notDuplicatedMarkStates.join(', ');
      hikeOptions.add(hikeOption);
    }

    return hikeOptions;
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString()} hours ${minutes.toString().padLeft(2, "0")} minutes';
  }

  Future<List<PortionDetail>> getPortionDetails(int departurePointId, int destinationPointId) async {
    final db = await database;

    final queryString = '''
    Select StartPoint.Name || ' - ' || DestinationPoint.Name as PortionName,
    StartPoint.Name as StartPointName, DestinationPoint.Name as DestinationPointName,
    Portion.Duration, MarkType.Name as Mark, MarkState.Description as MarkState,
    Portion.Description, CTP.CacheTrekID as CacheTrekId
    from Cache_Trek_Portions CTP
    inner join Portion
    on Portion.ID = CTP.IDPortion
    Inner Join Point as StartPoint
    on Portion.StartPointID = StartPoint.ID
    Inner Join Point as DestinationPoint
    on Portion.DestinationPointID = DestinationPoint.ID
    Inner Join MarkType
    On Portion.MarkType = MarkType.ID
    Inner Join MarkState
    On Portion.MarkState = MarkState.ID
    Where CTP.CacheTrekID = (
    Select CT.ID as CacheTrekID from Cache_Trek CT
    inner join point as DeparturePoint
    on CT.IDDepPoint = DeparturePoint.ID
    inner join point as DestinationPoint
    on CT.IDDestPoint = DestinationPoint.ID
    where CT.IDDepPoint = $departurePointId
    And CT.IDDestPoint = $destinationPointId
    limit 1
    )
    Order by CTP.PortionOrder'''
    ;

    var result = await db.rawQuery(queryString);

    if(result.isEmpty)
      return [];

    return result.isNotEmpty ? result.map((o) => PortionDetail.fromDatabase(o)).toList() : [];
  }



  Future<List<Point>> searchPointByName(String searchPointName) async {
    final db = await database;


    final getPointsForAutocompleteQuerry = '''
      Select ID, Name, Description 
      From Point
      Where Name like '%$searchPointName%'
      Limit 5
    ''';

    var result = await db.rawQuery(getPointsForAutocompleteQuerry);
    return result.isNotEmpty ? result.map((o) => Point.fromDatabase(o)).toList() : [];
  }
}