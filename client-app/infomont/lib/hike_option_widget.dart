import 'package:flutter/material.dart';

class HikeOptionWidget extends StatelessWidget {
  const HikeOptionWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: <Widget>[
      Text('Breaza - Peaks Brezei - Chalet Urlea' ' | ' 'Show map'),
      Text('Duration: ' '3h 30min'),
      Text('Mark: ' 'Red Triangle'),
      Text('Mark quality: ' 'good'),
      Text('Difficulty: ' 'easy'),
      Text('Description: ' 'From Breaza, from the final station of the bus, the marks with blue triangle lead us to the point called "Pe Livadia" ("At the orchard"), where there is a orchard nursery. Here there is a pole with indicating plates.')
    ],));
  }
}