import 'package:binge/services/tmdb_service.dart';
import 'package:binge/views/infinite_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('Infinite list is displayed', (tester) async {
    final tmdb = TMDBService();

    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InfiniteList(
                  apiCall: tmdb.getTodaysTVShows,
                  header: 'Test',
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Create the Finders.
    final headerTextFinder = find.text('Test');
    final listFinder = find.byType(InfiniteList);

    // Verify that list renders.
    expect(headerTextFinder, findsOneWidget);

    final baseSize = tester.getSize(listFinder);
    expect(baseSize.height, equals((206 * 0.8) + 24 + 8 + 21));
  });
}
