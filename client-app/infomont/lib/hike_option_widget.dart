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
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Description: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFEFDD124))),
                            TextSpan(
                                text: '${hikeOption.shortDescription}',
                                style: TextStyle(color: Color(0xFFE0E2DB))),
                            TextSpan(children: convertToDescriptionWithMarks(hikeOption.shortDescription, hikeOption.markImages),
                              style: TextStyle(color: Color(0xFFE0E2DB)),)
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

  convertToDescriptionWithMarks(shortDescription, Iterable<InfomontImage> markImages) {
    var result = List<InlineSpan>();

    //var regexPattern = get only the image codes that we expect instead all the images in the pattern below

    // pattern = RegExp("BA|BG|BR|PA|PG|PR|TA|TG|TR|CA|CG|CA") /
    // matches = pattern.allMatches(shortDescription)
    // for (match in matches) result.add( isCode(match) ? WidgetSpan(image) : TextSpan(match) )

    result.add(TextSpan(text: shortDescription ));
    return result;
  }
}
