import 'dart:convert';
import 'dart:developer';

import 'package:binge/models/tmdb_result.dart';
import 'package:binge/views/list_card.dart';
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
          return snapshot.data != ""
              ? HistoryList(
                  history: snapshot.data!,
                )
              : const NoHistory();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key, required this.history}) : super(key: key);

  final dynamic history;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 62,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 16, left: 16),
                child: Text(
                  'Recent Searches',
                  textScaleFactor: 1.25,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            for (var item in history)
              SizedBox(
                height: 170,
                child: ListCard(
                  item: TMDBResults.fromJson(jsonDecode(item)),
                ),
              ),
            TextButton(
              onPressed: () => spService.clearHistory(),
              child: const Text('Clear History'),
            ),
          ],
        ),
      ),
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
        children: const [
          Text(
            'Find your next story',
            textScaleFactor: 1.25,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'Search for TV Series, Movies, Actors and more',
              textScaleFactor: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
