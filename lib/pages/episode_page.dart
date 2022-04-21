import 'package:binge/models/tmdb/tmdb_season.dart';
import 'package:flutter/material.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_result.dart';
import '../services/tmdb_service.dart';
import '../views/poster_card.dart';
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
                var list = <dynamic>["test"];
                if (snapshot.data?.episodes != null) {
                  list.addAll(snapshot.data!.episodes!);
                }
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView.builder(
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
        padding: EdgeInsets.only(top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              episode.name ?? '',
              textScaleFactor: 1.25,
            ),
            Text(formatEpisodeNumber(
                episode.episodeNumber, episode.seasonNumber)),
            Text(episode.airDate ?? ''),
            Text(episode.voteAverage.toString()),
            //  for (var star in episode.guestStars) Text(star.toString())

            episode.guestStars != null
                ? SizedBox(
                    height: 0.8 * 206,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: episode.guestStars?.length ?? 0,
                      itemBuilder: (context, index) => PosterCard(
                        index: index,
                        listName: 'guestStars${episode.name}',
                        item:
                            TMDBResults.fromCredits(episode.guestStars?[index]),
                        scaleFactor: 0.8,
                      ),
                    ),
                  )
                : Text("JK"),

            Text(episode.overview ?? ''),
            TMDBImage(
              imagePath: episode.stillPath,
              bannerImage: true,
              width: MediaQuery.of(context).size.width - 32,
            )
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
