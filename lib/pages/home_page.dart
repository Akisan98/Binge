import 'package:flutter/material.dart';

import '../services/tmdb_service.dart';
import '../views/my_app_bar.dart';
import '../views/infinite_list.dart';
import '../views/search_bar/search_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TMDBService tmdb = TMDBService();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // NavBar
                const MyAppBar(
                  title: 'Search',
                  icon: Icons.person,
                ),

                // Search
                const SearchBar(),
                InfiniteList(
                  apiCall: tmdb.getTodaysTVShows,
                  header: 'Airing Today',
                ),
                InfiniteList(
                  apiCall: tmdb.getTrendingTVShows,
                  header: 'Trending TV Shows',
                ),
                InfiniteList(
                  apiCall: tmdb.getPopularTVShows,
                  header: 'Popular TV Shows',
                ),
                // Future Ad Placement
                // const Padding(
                //   padding: EdgeInsets.only(left: 8, top: 24, bottom: 8),
                //   child: Placeholder(
                //     fallbackHeight: 100,
                //   ),
                // ),
                InfiniteList(
                  apiCall: tmdb.getCurrentMovies,
                  header: 'Movies in Theaters',
                ),
                InfiniteList(
                  apiCall: tmdb.getPopularMovies,
                  header: 'Popular Movies',
                ),
                InfiniteList(
                  apiCall: tmdb.getTopRatedMovies,
                  header: 'Top Rated Movies',
                ),
              ],
            ),
          ),
        ),
      );
}
