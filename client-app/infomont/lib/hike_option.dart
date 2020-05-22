class HikeOption {
  var optionName;
  var duration;
  var shortDescription;
  var marks;
  var marksQuality;
  var startPoint;
  var destinationPoint;

  HikeOption(
      {this.optionName,
      this.duration,
      this.shortDescription,
      this.marks,
      this.marksQuality,
      this.startPoint,
      this.destinationPoint});

  factory HikeOption.fromJson(Map<String, dynamic> json) {
    return HikeOption(
        optionName: json['optionName'] as String,
        duration: json['duration'] as String,
        shortDescription: json['shortDescription'] as String,
        marks: json['marks'] as String,
        marksQuality: json['marksQuality'] as String);
  }

  factory HikeOption.fromDatabase(Map<String, dynamic> entry) {
    return HikeOption(
        optionName: entry['OptionName'] as String,
        duration: entry['Duration'].toString(),
        shortDescription: entry['ShortDescription'] as String,
        marks: entry['Marks'] as String,
        marksQuality: entry['MarksQuality'] as String,
        startPoint: entry['StartPoint'] as String,
        destinationPoint: entry['DestinationPoint'] as String);
  }

  @override
  bool operator ==(Object other) => // TODO: a deep equals would be cleaner...
      identical(this, other) ||
      other is HikeOption && runtimeType == other.runtimeType && optionName == other.optionName;

  @override
  int get hashCode => marks.hashCode;
}
