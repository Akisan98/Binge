import 'dart:developer';

import 'package:binge/models/db/media_content.dart';
import 'package:flutter/material.dart';

import '../models/tv/season.dart';
import '../utils/utils.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({Key? key, required this.seasons, required this.onPressed})
      : super(key: key);

  final List<DBSeasons>? seasons;
  static Utils utils = Utils();

  /// What happens when + button is pressed.
  final SeasonCallback onPressed;

  @override
  Widget build(BuildContext context) {
    log('Build - SeasonList');
    if (utils.isListEmpty(seasons)) {
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
  const SeasonCard({Key? key, required this.season, required this.callback})
      : super(key: key);

  final DBSeasons season;

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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .75,
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
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 32),
                child: LinearProgressIndicator(
                  value: calculateProgress(
                      widget.season.episodes, widget.season.episodesSeen),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: IconButton(
            onPressed: () {
              widget.callback(
                  widget.season.episodes!, widget.season.seasonNumber!);
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
