import 'package:flutter/material.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_result.dart';
import '../models/tmdb/tmdb_season.dart';
import '../services/tmdb_service.dart';
import '../views/rating.dart';
import '../views/text_card.dart';
import '../views/tmdb_image.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({Key? key, required this.showId, required this.season})
      : super(key: key);

  final int showId;
  final DBSeasons season;
  static final TMDBService tmdb = TMDBService();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: FutureBuilder<TMDBSeason>(
            future: tmdb.getTVSeason(showId, season.seasonNumber ?? 1),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final list = <dynamic>['test'];
                if (snapshot.data?.episodes != null) {
                  list.addAll(snapshot.data!.episodes!);
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      thickness: 2,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) => index == 0
                        ? const Text('Header')
                        : EpisodeCard(
                            episode: list[index],
                          ),
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          //     SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       Text(season.name ?? ''),
          //       FutureBuilder<TMDBSeason>(
          //         future: tmdb.getTVSeason(showId, season.seasonNumber ?? 1),
          //         builder: (context, snapshot) {
          //           if (snapshot.hasData) {
          //             return Column(
          //               children: [
          //                 for (var item in snapshot.data!.episodes!)
          //                   EpisodeCard(
          //                     episode: item,
          //                   ),
          //               ],
          //             );
          //           }

          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         },
          //       )
          //     ],
          //   ),
          // ),
        ),
      );
}

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  final Episodes episode;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              episode.name ?? '',
              textScaleFactor: 1.25,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                formatEpisodeNumber(
                  episode.episodeNumber,
                  episode.seasonNumber,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(episode.airDate ?? ''),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Rating(
                rating: episode.voteAverage,
                mini: true,
              ),
            ),

            
            if (episode.guestStars != null && episode.guestStars!.length > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 16,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Text(', '),
                      scrollDirection: Axis.horizontal,
                      itemCount: episode.guestStars?.length ?? 0,
                    itemBuilder: (context, index) => TextCard(
                        item:
                            TMDBResults.fromCredits(
                        episode.guestStars?[index],
                      ),
                    ),
                  ),
                ),
              ) 
            else
              const SizedBox.shrink(),

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(episode.overview ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: TMDBImage(
                imagePath: episode.stillPath,
                bannerImage: true,
                width: MediaQuery.of(context).size.width - 32,
              ),
            ),
          ],
        ),
      );

  String formatEpisodeNumber(int? episode, int? season) {
    if (episode != null && season != null) {
      return 'Season $season Episode $episode';
    }
    return '';
  }
}
