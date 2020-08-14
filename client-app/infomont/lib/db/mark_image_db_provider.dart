
import 'package:app/db/abstract_db_provider.dart';
import 'package:app/entities/infomont_image.dart';

class MarkImageDbProvider {
  final IDBProvider dbProvider;

  MarkImageDbProvider(this.dbProvider);

  Future<List<InfomontImage>> getAllMarkImages() async{
    final db = await dbProvider.database;

    final queryString = '''
    Select MarkCode as id, Image  
    From MarkImages''';

    var result = await db.rawQuery(queryString);

    if (result.isEmpty) return [];

    return result.isNotEmpty
        ? result.map((o) => InfomontImage.fromDatabase(o)).toList()
        : [];
  }
}