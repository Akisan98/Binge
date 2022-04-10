import 'dart:developer';

import 'package:binge/models/tmdb_result.dart';
import 'package:binge/views/poster_card.dart';
import 'package:flutter/material.dart';
import 'package:binge/services/shared_preferences_service.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: spService.getHistoryStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          log("Data:" + snapshot.data.toString() + " - SearchHistory");
          return snapshot.data != "" ? const HistoryList() : const NoHistory();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 206,
          child: PosterCard(
            text: TMDBResults.fromJson(
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
        TextButton(
          onPressed: () => spService.clearHistory(),
          child: const Text('Clear History'),
        )
      ],
    );
  }
}

class NoHistory extends StatelessWidget {
  const NoHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: width * 0.2, right: width * 0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Find your next story',
            textScaleFactor: 1.25,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Search for TV Series, Movies, Actors and more',
              textScaleFactor: 1,
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: () => spService.addHistory('TestData'),
            child: const Text('Add history'),
          )
        ],
      ),
    );
  }
}
