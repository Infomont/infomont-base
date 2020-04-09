import 'dart:convert';

import 'package:flutter/material.dart';

import 'hike_option.dart';

class HikeOptionWidget extends StatelessWidget {
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

  final hikeOption = HikeOption.fromJson(jsonDecode(tmpJson));

  HikeOptionWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          title: Text(hikeOption.optionName),
          subtitle: Text('Duration: ${hikeOption.duration}'),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  child: Text('Description: ${hikeOption.shortDescription}')),
              Text(
                'Marks: ${hikeOption.marks}',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Marks quality: ${hikeOption.marksQuality} · Difficulty: ${hikeOption.difficulty}',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ]),
      ],
    ));
  }
}
