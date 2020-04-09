import 'dart:convert';

class HikeOption {
  // language=JSON
  final tmpJson = '''
{
  "optionName": "Breaza - Peaks Brezei - Chalet Urlea"
}
''';

  final String optionName;
  final duration = '3h 30min';
  final shortDescription =
      'From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called "Pe Livadia" ("At the orchard"), where there is a orchard nursery. Here there is a pole with indicating plates.';
  final marks = 'Red Triangle';
  final marksQuality = '★★★★☆';
  final difficulty = '★☆☆☆☆';

  HikeOption(this.optionName) {
    HikeOption.fromJson(jsonDecode(tmpJson));
  }
  
  HikeOption.fromJson(Map<String, dynamic> json)
      : optionName = json['optionName'];

}