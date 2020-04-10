class HikeOption {
  final optionName;
  final duration;
  final shortDescription;
  final marks;
  final marksQuality;
  final difficulty;

  HikeOption(
      {this.optionName,
      this.duration,
      this.shortDescription,
      this.marks,
      this.marksQuality,
      this.difficulty});

  factory HikeOption.fromJson(Map<String, dynamic> json) {
    return HikeOption(
        optionName: json['optionName'] as String,
        duration: json['duration'] as String,
        shortDescription: json['shortDescription'] as String,
        marks: json['marks'] as String,
        marksQuality: json['marksQuality'] as String,
        difficulty: json['difficulty'] as String);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HikeOption &&
              runtimeType == other.runtimeType &&
              marks == other.marks;

  @override
  int get hashCode => marks.hashCode;

}
