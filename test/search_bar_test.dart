import 'package:binge/pages/search_pages/active_search_page.dart';
import 'package:binge/views/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('Search bar is displayed', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: SearchBar(),
          ),
        ),
      ),
    );

    // Create the Finders.
    final hintTextFinder = find.text('TV Series, Movies, or Actors');
    final searchIconFinder = find.byIcon(Icons.search);
    final searchBarFinder = find.byType(SearchBar);

    // Verify that Search bar renders.
    expect(hintTextFinder, findsOneWidget);
    expect(searchIconFinder, findsOneWidget);
    expect(searchBarFinder, isNotNull);

    final Size baseSize = tester.getSize(searchBarFinder);
    expect(baseSize.height, equals(50 + 24 + 8));

    // Tap the search bar.
    await tester.tap(searchBarFinder);
    await tester.pumpAndSettle();

    // Verify that tapping search bar open Active Search Page.
    expect(find.byType(ActiveSearchPage), findsOneWidget);
  });
}
