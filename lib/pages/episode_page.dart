import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import '../models/db/media_content.dart';
import '../models/tmdb/tmdb_result.dart';
import '../models/tmdb/tmdb_season.dart';
import '../services/tmdb_service.dart';
import '../views/circular_checkbox.dart';
import '../views/rating.dart';
import '../views/text_card.dart';
import '../views/tmdb_image.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({Key? key, required this.showId, required this.season})
      : super(key: key);

  final int showId;
  final DBSeasons season;
  static final TMDBService tmdb = TMDBService();

  void episodeOnPressed(newValue, index) {
    season.episodesSeenArray![index - 1] = newValue;

    if (newValue == 1) {
      season.episodesSeen = (season.episodesSeen ?? 0) + 1;
    } else {
      season.episodesSeen = (season.episodesSeen ?? 1) - 1;
    }

    log(season.episodesSeenArray.toString());
    log(season.toString());
  }

  @override
  Widget build(BuildContext context) {
    log(season.toString());
    if (season.episodesSeen == null || season.episodesSeenArray == null) {
      season.episodesSeen = 0;
      season.episodesSeenArray = List.filled(season.episodes ?? 0, 0);
    }
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<TMDBSeason>(
          future: tmdb.getTVSeason(showId, season.seasonNumber ?? 1),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final list = <dynamic>['Season ${season.seasonNumber ?? 1}'];
              if (snapshot.data?.episodes != null) {
                list.addAll(snapshot.data!.episodes!);
              }
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox.shrink();
                    }

                    return Divider(
                      thickness: 2,
                      color: Theme.of(context).colorScheme.tertiary,
                    );
                  },
                  itemCount: list.length,
                  itemBuilder: (context, index) => index == 0
                      ? Text(
                          list[index],
                          textScaleFactor: 1.75,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : EpisodeCard(
                          episode: list[index],
                          index: index - 1,
                          seen: season.episodesSeenArray![index - 1],
                          onChanged: (newValue) {
                            episodeOnPressed(newValue, index);
                          },
                        ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key? key,
    required this.episode,
    required this.index,
    required this.seen,
    required this.onChanged,
  }) : super(key: key);

  final Episodes episode;
  final int index;
  final int seen;
  final CheckboxCallback onChanged;

  @override
  Widget build(BuildContext context) {
    log('CircularCheckbox - Build');
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: Text(
                  episode.name ?? '',
                  textScaleFactor: 1.5,
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              CircularCheckbox(
                seen: seen,
                onChanged: onChanged.call,
              ),
            ],
          ),
          Text(
            formatEpisodeNumber(
              episode.episodeNumber,
              episode.seasonNumber,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
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
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                height: 16,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Text(', '),
                  scrollDirection: Axis.horizontal,
                  itemCount: episode.guestStars?.length ?? 0,
                  itemBuilder: (context, index) => TextCard(
                    item: TMDBResults.fromCredits(
                      episode.guestStars?[index],
                    ),
                  ),
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          if (episode.overview != null && episode.overview != '')
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(episode.overview ?? ''),
            )
          else
            const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            child: TMDBImage(
              imagePath: episode.stillPath,
              bannerImage: true,
              width: MediaQuery.of(context).size.width - 32,
            ),
          ),
        ],
      ),
    );
  }

  String formatEpisodeNumber(int? episode, int? season) {
    if (episode != null && season != null) {
      return 'Season $season Episode $episode';
    }
    return '';
  }
}
