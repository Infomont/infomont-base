// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('Finds StartingPoint Input Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(InfoMontApp());

    expect(find.widgetWithText(TextFormField, 'Starting point'), findsOneWidget, reason: 'There is one TextFormField with "Starting point" text');
  });

  testWidgets('Finds EndPoint Input Field', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(InfoMontApp());

    expect(find.widgetWithText(TextFormField, 'End point'), findsOneWidget, reason: 'There is one TextFormField with "End point" text');
  });
}