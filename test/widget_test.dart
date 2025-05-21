// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import the actual main app widget or the screen to test
import 'package:test_app/routes/penguinListScreen.dart'; 

void main() {
  testWidgets('App starts and shows PenguinListRoute smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // As per main.dart, the root is MaterialApp wrapping PenguinListRoute
    await tester.pumpWidget(MaterialApp(home: PenguinListRoute()));

    // Verify that something from PenguinListRoute is present.
    // For example, check for the AppBar title.
    expect(find.text('Penguins'), findsOneWidget);
  });
}
