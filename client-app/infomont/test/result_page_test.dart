import 'dart:async';
import 'package:app/entities/hike_option.dart';
import 'package:app/entities/hike_option_search_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/pages/result_page.dart';
import 'database/hike_option_json_provider.dart';
import 'database/json_adapter.dart';

// TODO: extract to helper file
Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

void main() {
  testWidgets('Displays progress indicator before showing results',
      (WidgetTester tester) async {
    var hikeOptionProvider = HikeOptionJsonProvider(JsonAdapter());
    await tester.pumpWidget(buildTestableWidget(ResultPage(
        hikeOptionProvider: hikeOptionProvider,
        searchParameters: HikeOptionSearchParameters(
            4711,
            'random departure pt',
            0815,
            'random destination pt'), // arbitrary ids
        title: 'Not interesting - Results Page Title')));

    final progressIndicatorFinder = find.byType(CircularProgressIndicator);
    expect(progressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Displays 3 different route options',
      (WidgetTester tester) async {
    final route1Text = 'Route 1: Test';
    final route2Text = 'Route 2: Test';
    final route3Text = 'Route 3: Test';
    var result = List<HikeOption>();
    result.add(HikeOption(optionName: route1Text));
    result.add(HikeOption(optionName: route2Text));
    result.add(HikeOption(optionName: route3Text));
    var hikeOptionProvider = HikeOptionProviderStub(result, JsonAdapter());
    var resultPage = ResultPage(
        hikeOptionProvider: hikeOptionProvider,
        searchParameters: HikeOptionSearchParameters(
            4711,
            'random departure pt',
            0815,
            'random destination pt'), // arbitrary ids
        title: 'Not interesting - Results Page Title');
    await tester.pumpWidget(buildTestableWidget(resultPage));
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => fromRichTextToPlainText(widget).contains(route1Text)), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => fromRichTextToPlainText(widget).contains(route2Text)), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => fromRichTextToPlainText(widget).contains(route3Text)), findsOneWidget);
  });
}

String fromRichTextToPlainText(final Widget widget) { // taken from https://stackoverflow.com/a/60791156/3067733
  if (widget is RichText) {
    if (widget.text is TextSpan) {
      final buffer = StringBuffer();
      (widget.text as TextSpan).computeToPlainText(buffer);
      return buffer.toString();
    }
  }
  return "";
}

class HikeOptionProviderStub extends HikeOptionJsonProvider {
  HikeOptionProviderStub(this.hikeOptions, JsonAdapter jsonAdapter)
      : super(jsonAdapter);
  final List<HikeOption> hikeOptions;

  @override
  Future<List<HikeOption>> fetchHikeOptions(
      int departurePointId, int destinationPointId) async {
    return this.hikeOptions;
  }
}
