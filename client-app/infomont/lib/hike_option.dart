import 'dart:convert';

class HikeOption {
  // language=JSON
  static const tmpJson = '''
{
  "optionName": "Breaza - Peaks Brezei - Chalet Urlea",
  "duration": "3h 30min",
  "shortDescription": " From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called \\\"Pe Livadia\\\" (\\\"At the orchard\\\"), where there is a orchard nursery. Here there is a pole with indicating plates. ",
  "marks": "Red Triangle",
  "marksQuality": "★★★★☆",
  "difficulty": "★☆☆☆☆"
}
''';

  final optionName;
  final duration;
  final shortDescription;
  final marks;
  final marksQuality;
  final difficulty;

  HikeOption() : this.fromJson(jsonDecode(tmpJson));

  HikeOption.fromJson(Map<String, dynamic> json)
      : optionName = json['optionName'],
        duration = json['duration'],
        shortDescription = json['shortDescription'],
        marks = json['marks'],
        marksQuality = json['marksQuality'],
        difficulty = json['difficulty'];
}
