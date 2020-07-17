import 'dart:ui';

import 'package:flutter/material.dart';

import 'InfomontImage.dart';
import 'hike_option.dart';

class HikeOptionWidget extends StatelessWidget {
  final hikeOption;

  HikeOptionWidget(
    HikeOption hikeOption, {
    Key key,
  })  : hikeOption = hikeOption,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xFF445B18),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: '${hikeOption.optionNumber}: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFEFDD124))),
                    TextSpan(
                        text: hikeOption.optionName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFEFDD124)))
                  ])),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          child: RichText(
                              text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                            TextSpan(
                                text: 'Duration: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFEFDD124))),
                            TextSpan(
                                text: '${hikeOption.duration}',
                                style: TextStyle(color: Color(0xFFE0E2DB))),
                          ]))),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <InlineSpan>[
                            TextSpan(
                                text: 'Description: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFEFDD124))),
                            WidgetSpan(
                              child: FutureBuilder<dynamic>(
                              future: convertToDescriptionWithMarks(hikeOption.shortDescription, hikeOption.allMarkImages),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError)
                                    print(snapshot.error);

                                  return snapshot.hasData
                                      ? RichText(text: TextSpan(
                                    children: snapshot.data,
                                    style: TextStyle(color: Color(0xFFE0E2DB)),))
                                      : Center(child: CircularProgressIndicator());
                                })
                            ),
                          ],
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                            TextSpan(
                                text: 'Marks: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFEFDD124))),
                            TextSpan(
                              children: convertImagesToWidgetSpans(
                                  hikeOption.markImages),
                            ),
                          ])),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Marks quality: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFEFDD124))),
                            TextSpan(
                                text: '${hikeOption.marksQuality}',
                                style: TextStyle(color: Color(0xFEFDD124))),
                          ],
                        ),
                      ),
                    ])),
          ],
        ));
  }

  convertImagesToWidgetSpans(Iterable<InfomontImage> markImages) {
    return markImages
        .map((e) => TextSpan(
            children: [WidgetSpan(child: e.image), TextSpan(text: ' ')]))
        .toList();
  }

  convertToDescriptionWithMarks(String shortDescription, Future<List<InfomontImage>> allMarkImagesFuture) async {
    var result = List<InlineSpan>();
    var allMarkImages = await allMarkImagesFuture;

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
    return  result;
  }

  getImage(match, List<InfomontImage> markImages) {
    return markImages.firstWhere((mi) => mi.id == match.toString()).image;
  }
}