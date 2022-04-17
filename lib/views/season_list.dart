import 'package:binge/models/tv/season.dart';
import 'package:binge/utils/utils.dart';
import 'package:flutter/widgets.dart';

class SeasonList extends StatelessWidget {
  const SeasonList({Key? key, required this.seasons}) : super(key: key);

  final List<Seasons>? seasons;
  static Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    if (utils.isListEmpty(seasons)) {
      return const Text('No Data');
    } else {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        for (var item in seasons!)
          item.seasonNumber == 1
              ? Text(item.toString())
              : SeasonCard(
                  season: item,
                ),
      ]);
    }
  }
}

class SeasonCard extends StatelessWidget {
  const SeasonCard({Key? key, required this.season}) : super(key: key);

  final Seasons season;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(season.name ?? ''),
        Text(season.episodeCount.toString()),
        Text(season.airDate.toString()),
        Text(season.seasonNumber.toString()),
        Text(season.id.toString())
      ],
    );
  }
}
