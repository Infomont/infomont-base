import 'dart:ui';
import 'package:app/widgets/mark_images_helper.dart';
import 'package:flutter/material.dart';
import '../entities/hike_option.dart';
import 'hike_option_widget_helper.dart';

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
              title: buildHikeOptionTitleText(context, optionNumber: hikeOption.optionNumber, optionName: hikeOption.optionName),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      buildDurationText(context, label: 'Duration: ', body: hikeOption.duration),
                      buildDescriptionText(context, label: 'Description: ', body: HikeOptionWidgetHelper().convertToDescriptionWithMarks(hikeOption.shortDescription, hikeOption.allMarkImages)),
                      buildMarksText(context, label: 'Marks: ', body: MarkImagesHelper().convertImagesToWidgetSpans(hikeOption.markImages)),
                      buildMarksQualityText(context, label: 'Marks quality: ', body: hikeOption.marksQuality),
                    ])),
          ],
        ));
  }

  RichText buildHikeOptionTitleText(BuildContext context, {int optionNumber, String optionName}) {
    return RichText(
        text: TextSpan(
              text: '$optionNumber: $optionName',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFEFDD124))),
            );
  }

  RichText buildDurationText(BuildContext context, {String label, String body}) {
    return RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              buildLabel(label),
              TextSpan(
                  text: body,
                  style: TextStyle(color: Color(0xFFE0E2DB))),
            ]));
  }

  RichText buildDescriptionText(BuildContext context, {String label, Future<List<InlineSpan>> body}) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <InlineSpan>[
          buildLabel(label),
          WidgetSpan(
              child: FutureBuilder<dynamic>(
                  future: body,
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
    );
  }

  RichText buildMarksText(BuildContext context, {String label, List<InlineSpan> body}) {
    return RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              buildLabel(label),
              TextSpan(
                children: body,
              ),
            ]));
  }

  RichText buildMarksQualityText(BuildContext context, {String label, String body}) {
    return RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            buildLabel(label),
            TextSpan(
                text: body,
                style: TextStyle(color: Color(0xFEFDD124))),
          ],
        ),
      );
  }

  TextSpan buildLabel(String label) {
    return TextSpan(
      text: label,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFEFDD124)));
  }

}