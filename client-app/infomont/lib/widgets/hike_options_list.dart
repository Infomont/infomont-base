import 'package:app/entities/hike_option.dart';
import 'package:flutter/cupertino.dart';

import 'hike_option_widget.dart';

class HikeOptionsList extends StatelessWidget {
  final List<HikeOption> hikeOptions;

  HikeOptionsList({Key key, this.hikeOptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hikeOptions.length,
      itemBuilder: (context, index) {
        return HikeOptionWidget(hikeOptions[index]);
      },
    );
  }
}