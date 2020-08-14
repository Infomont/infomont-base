
import 'package:app/db/abstract_db_provider.dart';
import 'package:app/db/mark_image_db_provider.dart';
import 'package:app/entities/hike_option.dart';
import 'package:app/entities/infomont_image.dart';
import 'package:app/entities/portion_detail.dart';

class HikeOptionBuilder {
  final IDBProvider dbProvider;
  final MarkImageDbProvider markImageProvider;

  HikeOptionBuilder(this.dbProvider) : markImageProvider = MarkImageDbProvider(dbProvider);

  HikeOption buildHikeOption(List<PortionDetail> currentTrackPortionDetails,
      int optionNumber,
      int durationSum,
      Iterable<String> marks,
      Iterable<InfomontImage> marksImages,
      Iterable<String> markStates) {

    HikeOption hikeOption = HikeOption(markStates: markStates);
    hikeOption.optionName = currentTrackPortionDetails[0].startPointName
        + ' - ' + currentTrackPortionDetails[currentTrackPortionDetails.length - 1].destinationPointName;
    hikeOption.optionNumber = optionNumber;
    hikeOption.duration = 0;
    hikeOption.shortDescription = getDescription(currentTrackPortionDetails);
    hikeOption.duration = getTimeString(durationSum);
    hikeOption.marks = marks.join(', ');
    hikeOption.markImages = marksImages;
    hikeOption.allMarkImages = markImageProvider.getAllMarkImages();
    return hikeOption;
  }

  static String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString()} hours ${minutes.toString().padLeft(2, "0")} minutes';
  }

  static String getDescription(List<PortionDetail> currentTrackPortionDetails) {
    if(currentTrackPortionDetails[0].englishDescription == null) { // return english description if there is any
      return  currentTrackPortionDetails[0].description;
    }
    return currentTrackPortionDetails[0].englishDescription;
  }
}