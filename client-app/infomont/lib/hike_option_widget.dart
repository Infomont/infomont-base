import 'package:flutter/material.dart';

class HikeOptionWidget extends StatelessWidget {
  final optionName = 'Breaza - Peaks Brezei - Chalet Urlea';
  final duration = '3h 30min';
  final shortDescription =
      'From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called "Pe Livadia" ("At the orchard"), where there is a orchard nursery. Here there is a pole with indicating plates.';
  final marks = 'Red Triangle';
  final marksQuality = '★★★★☆';
  final difficulty = '★☆☆☆☆';

  const HikeOptionWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          title: Text(optionName),
          subtitle: Text('Duration: $duration'),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(child: Text('Description: $shortDescription')),
              Text(
                'Marks: $marks',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Marks quality: $marksQuality · Difficulty: $difficulty',
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
