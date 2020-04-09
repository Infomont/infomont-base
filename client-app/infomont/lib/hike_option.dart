import 'dart:convert';

class HikeOption {
  // language=JSON
  static const tmpJson = '''
{
  "optionName": "Breaza - Peaks Brezei - Chalet Urlea",
  "duration": "3h 30min"
}
''';

  final optionName;
  final duration;
  final shortDescription =
      'From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called "Pe Livadia" ("At the orchard"), where there is a orchard nursery. Here there is a pole with indicating plates.';
  final marks = 'Red Triangle';
  final marksQuality = '★★★★☆';
  final difficulty = '★☆☆☆☆';

  HikeOption() :
        this.fromJson(jsonDecode(tmpJson));

  HikeOption.fromJson(Map<String, dynamic> json)
      : optionName = json['optionName'],
        duration = json['duration'];

}