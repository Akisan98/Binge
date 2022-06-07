import 'package:flutter/material.dart';

import '../services/tmdb_service.dart';
import '../views/home_page/infinite_list.dart';
import '../views/my_app_bar.dart';
import '../views/my_library/media_title.dart';
import '../views/search_bar/search_bar.dart';

typedef SearchBoxTapped = void Function();

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.onTapped}) : super(key: key);

  final TMDBService tmdb = TMDBService();
  final SearchBoxTapped onTapped;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: CustomScrollView(
            slivers: [
                // NavBar
              const SliverToBoxAdapter(
                child: MyAppBar(
                  title: 'Search',
                  icon: Icons.settings,
                ),
              ),
              
                // Search
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: onTapped.call,
                  child: const SearchBar(),
                ),
              ),

              const MediaTitle(
                display: true,
                title: 'Airing Today',
                leftPadding: 8,
              ),
                InfiniteList(
                  apiCall: tmdb.getTodaysTVShows,
                  header: 'Airing Today',
                ),

              const MediaTitle(
                display: true,
                title: 'Trending TV Shows',
                leftPadding: 8,
              ),
                InfiniteList(
                  apiCall: tmdb.getTrendingTVShows,
                  header: 'Trending TV Shows',
                ),

              const MediaTitle(
                display: true,
                title: 'Popular TV Shows',
                leftPadding: 8,
              ),
                InfiniteList(
                  apiCall: tmdb.getPopularTVShows,
                  header: 'Popular TV Shows',
                ),

              //     // Future Ad Placement
              //     // const Padding(
              //     //   padding: EdgeInsets.only(left: 8, top: 24, bottom: 8),
              //     //   child: Placeholder(
              //     //     fallbackHeight: 100,
              //     //   ),
              //     // ),

              const MediaTitle(
                display: true,
                title: 'Movies in Theaters',
                leftPadding: 8,
              ),
                InfiniteList(
                  apiCall: tmdb.getCurrentMovies,
                  header: 'Movies in Theaters',
                ),

              const MediaTitle(
                display: true,
                title: 'Popular Movies',
                leftPadding: 8,
              ),
                InfiniteList(
                  apiCall: tmdb.getPopularMovies,
                  header: 'Popular Movies',
                ),

              const MediaTitle(
                display: true,
                title: 'Top Rated Movies',
                leftPadding: 8,
              ),
                InfiniteList(
                  apiCall: tmdb.getTopRatedMovies,
                  header: 'Top Rated Movies',
                ),
              ],
          ),
        ),
      );
}
