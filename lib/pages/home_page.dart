import 'dart:developer';

import 'package:binge/models/tmdb_response.dart';
import 'package:binge/services/tmdb_service.dart';
import 'package:binge/views/horizontal_list.dart';
import 'package:binge/views/poster_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TMDBService tmdb = TMDBService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Hello World"),
            const SizedBox(
              child: Text("Future Search Box"),
              height: 75,
              width: double.infinity,
            ),
            HorizontalList(
                header: "Trending TV Shows", future: tmdb.getTrendingTVShows()),
            HorizontalList(
                header: "Popular TV Shows", future: tmdb.getPopularTVShows()),
          ],
        ),
      ),
    );
  }
}
