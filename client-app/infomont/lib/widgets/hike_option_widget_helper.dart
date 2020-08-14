import 'package:app/entities/infomont_image.dart';
import 'package:flutter/cupertino.dart';

class HikeOptionWidgetHelper{

  Future<List<InlineSpan>> convertToDescriptionWithMarks(String shortDescription, Future<List<InfomontImage>> allMarkImagesFuture) async {
    var result = List<InlineSpan>();
    var allMarkImages = await allMarkImagesFuture;

    if (allMarkImages.length == 0)
    {
      result.add(TextSpan(text: shortDescription));
      return result;
    }

    String regexPattern = allMarkImages.map((element) => element.id.toString()).reduce((value, element) => value + "|" + element);

    var pattern = RegExp(regexPattern);
    var matches = pattern.allMatches(shortDescription);
    var lastMatchEnd = 0;
    for (var match in matches) {
      result.add(TextSpan(text: shortDescription.substring(lastMatchEnd, match.start)));
      var matchedString = match.group(0);
      lastMatchEnd = match.start + matchedString.length;
      result.add(WidgetSpan(child: getImage(matchedString, allMarkImages)));
    }
    result.add(TextSpan(text: shortDescription.substring(lastMatchEnd)));
    return result;
  }

  Widget getImage(match, List<InfomontImage> markImages) {
    return markImages.firstWhere((mi) => mi.id == match.toString()).image;
  }
}