import 'package:flutter/material.dart';

import 'hike_option.dart';

class HikeOptionWidget extends StatelessWidget {
  final hikeOption = HikeOption();

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
              Container(child: Text('Description: $hikeOption.shortDescription')),
              Text(
                'Marks: $hikeOption.marks',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Marks quality: $hikeOption.marksQuality · Difficulty: $hikeOption.difficulty',
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
