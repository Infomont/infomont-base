
import 'package:app/db/abstract_db_provider.dart';
import 'package:app/db/db_provider.dart';
import 'package:app/entities/point.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PointDbProvider{
  final IDBProvider dbProvider;

  PointDbProvider(this.dbProvider);

  Future<List<Point>> searchPointByName(String searchPointName) async {
    final db = await this.dbProvider.database;

    final getPointsForAutocompleteQuery = '''
      Select ID, Name, Description 
      From Point
      Where Name like '%$searchPointName%'
      Limit 5
    ''';

    var result = await db.rawQuery(getPointsForAutocompleteQuery);
    return result.isNotEmpty
        ? result.map((o) => Point.fromDatabase(o)).toList()
        : [];
  }
}