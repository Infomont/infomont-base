
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/result_page.dart';

// TODO: extract to helper file
Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

void main() {
  testWidgets('Displays 3 different route options', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(buildTestableWidget(ResultPage( title: '')));

    expect(find.text('Route 1: Test'), findsOneWidget);
    expect(find.text('Route 2: Test'), findsOneWidget);
    expect(find.text('Route 3: Test'), findsOneWidget);
  });
}