import 'package:app/db_provider.dart';
import 'package:app/hike_option_provider.dart';

import 'hike_option.dart';

class HikeOptionDbProvider extends HikeOptionProvider {
  Future<List<HikeOption>> fetchHikeOptions(
      int departurePointId, int destinationPointId) async {
    return DBProvider.db.getHikeOptions(departurePointId, destinationPointId);
  }
}
