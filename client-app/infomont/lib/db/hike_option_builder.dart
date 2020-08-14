
import 'package:app/db/abstract_db_provider.dart';
import 'package:app/db/mark_image_db_provider.dart';
import 'package:app/entities/hike_option.dart';
import 'package:app/entities/infomont_image.dart';
import 'package:app/entities/portion_detail.dart';

class HikeOptionBuilder {
  final IDBProvider dbProvider;

  HikeOptionBuilder(this.dbProvider);

  HikeOption buildHikeOption(List<PortionDetail> currentTrackPortionDetails, int optionNumber, int durationSum, Set<String> notDuplicatedMarks, Set<InfomontImage> notDuplicatedMarksImages, Set<String> notDuplicatedMarkStates) {
    HikeOption hikeOption = new HikeOption();
    hikeOption.optionName = currentTrackPortionDetails[0].startPointName
        + ' - ' + currentTrackPortionDetails[currentTrackPortionDetails.length - 1].destinationPointName;
    hikeOption.optionNumber = optionNumber;
    hikeOption.duration = 0;
    hikeOption.shortDescription = getDescription(currentTrackPortionDetails);
    hikeOption.duration = getTimeString(durationSum);
    hikeOption.marks = notDuplicatedMarks.join(', ');
    hikeOption.markImages = notDuplicatedMarksImages;
    hikeOption.marksQuality = notDuplicatedMarkStates.join(', ');
    hikeOption.allMarkImages = MarkImageDbProvider(dbProvider).getAllMarkImages();
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