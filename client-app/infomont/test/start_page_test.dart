// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/pages/start_page.dart';

// TODO: extract to helper file
Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

void main() {
  testWidgets('Finds StartingPoint Input Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(buildTestableWidget(StartPage(title: '')));

    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField &&
            widget.decoration.labelText == "Starting point"),
        findsOneWidget,
        reason: 'There is one TextField with "Starting point" text');
  });

  testWidgets('Finds EndPoint Input Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(buildTestableWidget(StartPage(title: '')));

    expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is TextField && widget.decoration.labelText == 'End point'),
        findsOneWidget,
        reason: 'There is one TextFormField with "End point" text');
  });
}
