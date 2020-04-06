
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/result_page.dart';

void main() {
  testWidgets('Displays 3 different route options', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ResultPage());

    expect(find.text('Route 1'), findsOneWidget);
    expect(find.text('Route 2'), findsOneWidget);
    expect(find.text('Route 3'), findsOneWidget);
  });
}