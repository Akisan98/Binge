import 'package:binge/views/search_bar/animated_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('Search bar starts in Focused mode', (WidgetTester tester) async {
    TextEditingController _searchcontroller = TextEditingController();

    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AnimatedSearch(
              searchTextController: _searchcontroller,
            ),
          ),
        ),
      ),
    );

    // Create the Finders.
    final hintTextFinder = find.text('TV Series, Movies, or Actors');
    final chevronIconFinder = find.byIcon(Icons.chevron_left);
    final searchIconFinder = find.byIcon(Icons.search);

    // Verify that Search bar starts in Focused mode
    expect(hintTextFinder, findsNothing);
    expect(searchIconFinder, findsNothing);

    expect(chevronIconFinder, findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is AnimatedContainer &&
            widget.constraints!.heightConstraints().maxHeight == 62,
        description: "Search bar in focus should have height of 62",
      ),
      findsOneWidget,
    );
  });

  testWidgets('Search bar shows text when dismissed',
      (WidgetTester tester) async {
    TextEditingController _searchcontroller = TextEditingController();

    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: AnimatedSearch(
              searchTextController: _searchcontroller,
            ),
          ),
        ),
      ),
    );

    // Create the Finders.
    final hintTextFinder = find.text('TV Series, Movies, or Actors');
    final chevronIconFinder = find.byIcon(Icons.chevron_left);
    final searchIconFinder = find.byIcon(Icons.search);

    // Verify that Search bar starts in Focused mode
    expect(hintTextFinder, findsNothing);
    expect(searchIconFinder, findsNothing);

    expect(chevronIconFinder, findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is AnimatedContainer &&
            widget.constraints!.heightConstraints().maxHeight == 62,
        description: "Search bar in focus should have height of 62",
      ),
      findsOneWidget,
    );

    // Tap the '<' icon and dismiss search bar.
    await tester.tap(chevronIconFinder);
    await tester.pump();

    // Verify Search bar is dismissed
    expect(chevronIconFinder, findsNothing);

    expect(hintTextFinder, findsOneWidget);
    expect(searchIconFinder, findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is AnimatedContainer &&
            widget.constraints!.heightConstraints().maxHeight == 50,
        description: "Search bar not in focus should have height of 50",
      ),
      findsOneWidget,
    );
  });
}
