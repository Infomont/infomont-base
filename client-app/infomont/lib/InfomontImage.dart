import 'package:flutter/widgets.dart';

class InfomontImage {
  var id;
  var image;

  InfomontImage({this.id, this.image});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfomontImage &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory InfomontImage.fromDatabase(Map<String, dynamic> entry) {
    return InfomontImage(
        id: entry['id'] as String,
        image: Image.memory(entry['Image'], scale: 2.0));
  }
}
