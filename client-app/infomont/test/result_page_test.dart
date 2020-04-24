import 'dart:async';

import 'package:app/hike_option.dart';
import 'package:app/hike_option_json_provider.dart';
import 'package:app/json_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/result_page.dart';

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
    await tester.pumpWidget(buildTestableWidget(ResultPage(
        hikeOptionProvider: hikeOptionProvider,
        title: 'Not interesting - Results Page Title')));
    await tester.pumpAndSettle();

    expect(find.text(route1Text), findsOneWidget);
    expect(find.text(route2Text), findsOneWidget);
    expect(find.text(route3Text), findsOneWidget);
  });
}

class HikeOptionProviderStub extends HikeOptionJsonProvider {
  HikeOptionProviderStub(this.hikeOptions, JsonAdapter jsonAdapter)
      : super(jsonAdapter);
  final List<HikeOption> hikeOptions;

  @override
  Future<List<HikeOption>> fetchHikeOptions(String departurePoint, String destinationPoint) async {
    return this.hikeOptions;
  }
}
