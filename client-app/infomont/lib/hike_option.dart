class HikeOption {
  final optionName;
  final duration;
  final shortDescription;
  final marks;
  final marksQuality;
  final difficulty;

  HikeOption(this.optionName,
      this.duration,
      this.shortDescription,
      this.marks,
      this.marksQuality,
      this.difficulty);

  HikeOption.fromJson(Map<String, dynamic> json)
      : optionName = json['optionName'],
        duration = json['duration'],
        shortDescription = json['shortDescription'],
        marks = json['marks'],
        marksQuality = json['marksQuality'],
        difficulty = json['difficulty'];
}
