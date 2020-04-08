import 'package:flutter/material.dart';

class HikeOptionWidget extends StatelessWidget {
  const HikeOptionWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: <Widget>[
      ListTile(
        title: Text('Breaza - Peaks Brezei - Chalet Urlea'),
        subtitle: Text('Duration: ' '3h 30min'),
      ),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(child: Text('Description: ' 'From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called "Pe Livadia" ("At the orchard"), where there is a orchard nursery. Here there is a pole with indicating plates.')),
            Text(
              'Mark: ' 'Red Triangle',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black87,
              ),
            ),
            Text(
            'Mark quality: ' 'good'
                ' · '
                'Difficulty: ' 'easy'
                ' ★',
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
            ),
          ]),
    ],));
  }
}