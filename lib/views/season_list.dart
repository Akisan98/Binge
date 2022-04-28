import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:progress_indicator/progress_indicator.dart';

import '../models/db/db_season.dart';
import '../models/db/media_content.dart';
import '../pages/episode_page.dart';
import '../utils/utils.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({
    Key? key,
    required this.showId,
    required this.seasons,
    required this.onPressed,
  }) : super(key: key);

  final List<DBSeasons>? seasons;
  final int showId;

  /// What happens when + button is pressed.
  final SeasonCallback onPressed;

  @override
  Widget build(BuildContext context) {
    log('Build - SeasonList');
    if (Utils.isListEmpty(seasons)) {
      return const Text('No Data');
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var item in seasons!)
              SeasonCard(
                season: item,
                callback: onPressed,
                showId: showId,
              ),
          ],
        ),
      );
    }
  }
}

typedef SeasonCallback = void Function(
  int seenCount,
  int seasonNumber,
);

class SeasonCard extends StatefulWidget {
  const SeasonCard({
    Key? key,
    required this.showId,
    required this.season,
    required this.callback,
  }) : super(key: key);

  final DBSeasons season;
  final int showId;

  /// What happens when + button is pressed.
  final SeasonCallback callback;

  @override
  State<StatefulWidget> createState() => _SeasonCardState();
}

class _SeasonCardState extends State<SeasonCard> {
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    log('Build - SeasonCard');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            log('SeasonCard - Tapped ID: ${widget.season.seasonNumber}');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EpisodesPage(
                  season: widget.season,
                  showId: widget.showId,
                ),
              ),
            ).then((value) {
              setState(() {});
            });
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 96,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.season.name ??
                      generateFallbackTitle(widget.season.seasonNumber),
                  textScaleFactor: 1.4,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '${widget.season.episodesSeen} / ${widget.season.episodes}',
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8, bottom: 32),
                //   child: LinearProgressIndicator(
                //     value: calculateProgress(
                //         widget.season.episodes, widget.season.episodesSeen),
                //     minHeight: 8,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 32),
                  child: BarProgress(
                    percentage: calculateProgress(
                          widget.season.episodes,
                          widget.season.episodesSeen,
                        ) *
                        100,
                    backColor: Colors.black,
                    color: Theme.of(context).primaryColor,
                    showPercentage: false,
                    stroke: 8,
                    round: false,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: IconButton(
            onPressed: () {
              var newValue = 0;
              if (widget.season.episodesSeen != widget.season.episodes) {
                newValue = widget.season.episodes ?? 0;
              }

              widget.callback(
                newValue,
                widget.season.seasonNumber!,
              );

              setState(() {});
            },
            icon: const Icon(
              Icons.add,
              // color: Colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}

double calculateProgress(int? episodes, int? seen) {
  if (episodes != null && seen != null) {
    return seen / episodes;
  }

  return 0;
}

String generateFallbackTitle(int? seasonNumber) {
  if (seasonNumber != null) {
    // ignore: unnecessary_statements
    'Season $seasonNumber';
  }

  return '';
}
