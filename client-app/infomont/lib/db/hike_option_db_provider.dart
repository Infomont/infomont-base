import 'package:app/db/abstract_db_provider.dart';
import 'package:app/db/db_provider.dart';
import 'package:app/db/hike_option_provider.dart';
import 'package:app/entities/hike_option.dart';
import 'package:app/entities/infomont_image.dart';
import 'package:app/entities/portion_detail.dart';

class HikeOptionDbProvider extends HikeOptionProvider { // TODO: Cleanup next!
  final IDBProvider dbProvider;

  HikeOptionDbProvider(this.dbProvider);

  Future<List<HikeOption>> fetchHikeOptions(int departurePointId, int destinationPointId) async {
    List<HikeOption> hikeOptions = new List<HikeOption>();

    List<PortionDetail> portionDetails =
    await getPortionDetails(departurePointId, destinationPointId);

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

      int durationSum = 0;
      var notDuplicatedMarks = new Set<String>();
      var notDuplicatedMarksImages = new Set<InfomontImage>();
      var notDuplicatedMarkStates = new Set<String>();
      for (var portionDetail in currentTrackPortionDetails) {
        durationSum += portionDetail.duration;
        notDuplicatedMarks.add(portionDetail.mark);
        notDuplicatedMarksImages.add(portionDetail.markImage);
        notDuplicatedMarkStates
            .add(formatMarksQuality(portionDetail.markState));
      }

      HikeOption hikeOption = new HikeOption();
      hikeOption.optionName = currentTrackPortionDetails[0].startPointName +
          ' - ' +
          currentTrackPortionDetails[currentTrackPortionDetails.length - 1]
              .destinationPointName;
      hikeOption.optionNumber = optionNumber;
      hikeOption.duration = 0;
      hikeOption.shortDescription = getDescription(currentTrackPortionDetails);
      hikeOption.duration = getTimeString(durationSum);
      hikeOption.marks = notDuplicatedMarks.join(', ');
      hikeOption.markImages = notDuplicatedMarksImages;
      hikeOption.marksQuality = notDuplicatedMarkStates.join(', ');
      hikeOption.allMarkImages = getAllMarkImages();
      hikeOptions.add(hikeOption);
    }

    return hikeOptions;
  }

  // CAREFUL: Duplicated code with hike_option.dart
  static String formatMarksQuality(var marksQuality) {
    switch (marksQuality) {
      case 'Inexistent':
        return '☆';
      case 'Foarte rar':
        return '☆☆';
      case 'Deteriorat':
        return '☆☆☆';
      case 'Bun':
        return '☆☆☆☆';
      case 'Foarte bun':
        return '☆☆☆☆☆';
    }
    return marksQuality;
  }

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString()} hours ${minutes.toString().padLeft(2, "0")} minutes';
  }

  Future<List<PortionDetail>> getPortionDetails(
      int departurePointId, int destinationPointId) async {
    final db = await dbProvider.database;

    final queryString = '''
    Select StartPoint.Name || ' - ' || DestinationPoint.Name as PortionName,
    StartPoint.Name as StartPointName, DestinationPoint.Name as DestinationPointName,
    Portion.Duration, MarkImages.MarkCode as MarkCode, MarkImages.Image as MarkImage, MarkState.Description as MarkState,
    Portion.Description, CTP.CacheTrekID as CacheTrekId, PortionInt.Text as EnglishDescription, PortionInt.IdLang
    from Cache_Trek_Portions CTP
    inner join Portion
    on Portion.ID = CTP.IDPortion
    Inner Join Point as StartPoint
    on Portion.StartPointID = StartPoint.ID
    Inner Join Point as DestinationPoint
    on Portion.DestinationPointID = DestinationPoint.ID
    Inner Join MarkType
    On Portion.MarkType = MarkType.ID
    Inner Join MarkImages
    On Portion.MarkType = MarkImages.ID
    Inner Join MarkState
    On Portion.MarkState = MarkState.ID
    Left Outer Join PortionInt
    On PortionInt.IDField = Portion.ID
    And PortionInt.IdLang = (Select Id from Language where Language.LanguageParticle == "en-GB")
    Where CTP.CacheTrekID in (
    Select CT.ID as CacheTrekID from Cache_Trek CT
    inner join point as DeparturePoint
    on CT.IDDepPoint = DeparturePoint.ID
    inner join point as DestinationPoint
    on CT.IDDestPoint = DestinationPoint.ID
    where CT.IDDepPoint = $departurePointId
    And CT.IDDestPoint = $destinationPointId
    limit 10
    )
    Order by CTP.PortionOrder''';

    var result = await db.rawQuery(queryString);

    if (result.isEmpty) return [];

    return result.isNotEmpty
        ? result.map((o) => PortionDetail.fromDatabase(o)).toList()
        : [];
  }

  String getDescription(List<PortionDetail> currentTrackPortionDetails) {
    if(currentTrackPortionDetails[0].englishDescription == null) { // return english description if there is any
      return  currentTrackPortionDetails[0].description;
    }
    return currentTrackPortionDetails[0].englishDescription;
  }

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
