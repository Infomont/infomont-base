import 'package:app/entities/infomont_image.dart';
import 'package:flutter/cupertino.dart';

class MarkImagesHelper{

  List<InlineSpan> convertImagesToWidgetSpans(Iterable<InfomontImage> markImages) {
    return markImages
        .map((e) => TextSpan(
        children: [WidgetSpan(child: e.image), TextSpan(text: ' ')]))
        .toList();
  }
}