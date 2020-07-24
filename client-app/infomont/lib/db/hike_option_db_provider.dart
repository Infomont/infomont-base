import 'package:app/db/db_provider.dart';
import 'package:app/db/hike_option_provider.dart';
import 'package:app/entities/hike_option.dart';

class HikeOptionDbProvider extends HikeOptionProvider {
  Future<List<HikeOption>> fetchHikeOptions(
      int departurePointId, int destinationPointId) async {
    return DBProvider.db.getHikeOptions(departurePointId, destinationPointId);
  }
}
