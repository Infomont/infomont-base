import 'package:app/db/abstract_db_provider.dart';
import 'package:app/db/hike_option_builder.dart';
import 'package:app/db/hike_option_provider.dart';
import 'package:app/db/portion_detail_db_provider.dart';
import 'package:app/entities/hike_option.dart';
import 'package:app/entities/portion_detail.dart';

class HikeOptionDbProvider extends HikeOptionProvider {
  final IDBProvider dbProvider;

  HikeOptionDbProvider(this.dbProvider);

  Future<List<HikeOption>> fetchHikeOptions(int departurePointId, int destinationPointId) async {
    List<HikeOption> hikeOptions = new List<HikeOption>();

    List<PortionDetail> portionDetails =
    await PortionDetailDbProvider(this.dbProvider).getPortionDetails(departurePointId, destinationPointId);

    var portionDetailsByTrackId = new Map<int, List<PortionDetail>>();

    if (portionDetails.length == 0) return hikeOptions;

    for (var portionDetail in portionDetails) {
      if (!portionDetailsByTrackId.containsKey(portionDetail.cacheTrekId)) {
        portionDetailsByTrackId[portionDetail.cacheTrekId] =
        new List<PortionDetail>();
      }

      portionDetailsByTrackId[portionDetail.cacheTrekId].add(portionDetail);
    }

    var optionNumber = 0;
    for (var entry in portionDetailsByTrackId.entries) {
      optionNumber++;
      var currentTrackPortionDetails = entry.value;

      HikeOption hikeOption = HikeOptionBuilder(dbProvider).buildHikeOption(
          currentTrackPortionDetails,
          optionNumber
      );
      hikeOptions.add(hikeOption);
    }

    return hikeOptions;
  }

}
