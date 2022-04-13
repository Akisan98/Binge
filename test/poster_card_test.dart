import 'package:binge/models/tmdb_result.dart';
import 'package:binge/views/poster_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('Poster Card is displayed', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: SizedBox(
              height: 206,
              child: PosterCard(
                index: 0,
                listName: 'postCardTest',
                item: TMDBResults.fromJson(
                  {
                    "adult": false,
                    "backdrop_path": "/egoyMDLqCxzjnSrWOz50uLlJWmD.jpg",
                    "genre_ids": [28, 878, 35, 10751],
                    "id": 675353,
                    "original_language": "en",
                    "original_title": "Sonic the Hedgehog 2",
                    "overview":
                        "After settling in Green Hills, Sonic is eager to prove he has what it takes to be a true hero. His test comes when Dr. Robotnik returns, this time with a new partner, Knuckles, in search for an emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.",
                    "popularity": 8640.583,
                    "poster_path": "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg",
                    "release_date": "2022-03-30",
                    "title": "Sonic the Hedgehog 2",
                    "video": false,
                    "vote_average": 7.7,
                    "vote_count": 249
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Create the Finders.
    final textFinder = find.text('Sonic the Hedgehog 2');
    final imageFinder = find.byType(CachedNetworkImage);
    final posterCardFinder = find.byType(PosterCard);

    // Verify that Poster Card renders.
    expect(textFinder, findsOneWidget);
    expect(imageFinder, findsOneWidget);

    final Size baseSize = tester.getSize(posterCardFinder);
    expect(baseSize.height, equals(206));
  });
}
