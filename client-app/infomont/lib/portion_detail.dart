import 'package:flutter/widgets.dart';

import 'InfomontImage.dart';

class PortionDetail {
  final portionName;
  final startPointName;
  final destinationPointName;
  final duration;
  final mark;
  final markImage;
  final markState;
  final description;
  final cacheTrekId;

  PortionDetail(
      {this.portionName,
      this.startPointName,
      this.destinationPointName,
      this.duration,
      this.mark,
      this.markImage,
      this.markState,
      this.description,
      this.cacheTrekId});

  factory PortionDetail.fromDatabase(Map<String, dynamic> entry) {
    return PortionDetail(
        portionName: entry['PortionName'] as String,
        startPointName: entry['StartPointName'] as String,
        destinationPointName: entry['DestinationPointName'] as String,
        duration: entry['Duration'] as int, // TODO: convert to int
        mark: entry['Mark'] as String,
        markImage: InfomontImage(entry['Mark'] as String,
            Image.memory(entry['MarkImage'], scale: 2.0)),
        markState: entry['MarkState'] as String,
        description: entry['Description'] as String,
        cacheTrekId: entry['CacheTrekId'] as int);
  }
}
