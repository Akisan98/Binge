import 'dart:developer';

import 'package:binge/services/tmdb_service.dart';
import 'package:binge/views/infinite_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TMDBService tmdb = TMDBService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Hello World"),
              const SizedBox(
                child: Text("Future Search Box"),
                height: 75,
                width: double.infinity,
              ),
              InfiniteList(
                apiCall: tmdb.getTodaysTVShows,
                header: "Airing Today",
              ),
              InfiniteList(
                apiCall: tmdb.getTrendingTVShows,
                header: "Trending TV Shows",
              ),
              InfiniteList(
                apiCall: tmdb.getPopularTVShows,
                header: "Popular TV Shows",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
