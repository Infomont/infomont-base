import 'InfomontImage.dart';

class HikeOption {
  var optionName;
  var optionNumber;
  var duration;
  var shortDescription;
  var marks;
  var markImages = Set<InfomontImage>();
  var marksQuality;
  var startPoint;
  var destinationPoint;
  var allMarkImages = Future<List<InfomontImage>>.sync(()=>List<InfomontImage>());

  HikeOption(
      {this.optionName,
      this.optionNumber,
      this.duration,
      this.shortDescription,
      this.marks,
      this.marksQuality,
      this.startPoint,
      this.destinationPoint,
      });

  factory HikeOption.fromJson(Map<String, dynamic> json) {
    var marksQuality = json['marksQuality'] as String;
    var marksQualityStars = formatMarksQuality(marksQuality);

    return HikeOption(
        optionName: json['optionName'] as String,
        optionNumber: json['optionNumber'] as String,
        duration: json['duration'] as String,
        shortDescription: json['shortDescription'] as String,
        marks: json['marks'] as String,
        marksQuality: marksQualityStars);
  }


  // CAREFUL: Duplicated code with db_provider.dart
  static String formatMarksQuality(var marksQuality) {
    switch (marksQuality) {
      case 'Inexistent':
        return '*';
      case 'Foarte rar':
        return '**';
      case 'Deteriorat':
        return '***';
      case 'Bun':
        return '****';
      case 'Foarte bun':
        return '*****';
    }
    return marksQuality;
  }

  @override
  bool operator ==(Object other) => // TODO: a deep equals would be cleaner...
      identical(this, other) ||
      other is HikeOption &&
          runtimeType == other.runtimeType &&
          optionName == other.optionName;

  @override
  int get hashCode => marks.hashCode;
}
