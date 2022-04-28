import 'package:hive/hive.dart';

part 'db_season.g.dart';

@HiveType(typeId: 1)
class DBSeasons {
  @HiveField(0)
  int? episodesSeen;

  @HiveField(1)
  int? episodes;

  @HiveField(2)
  int? seasonNumber;

  @HiveField(3)
  String? name;

  @HiveField(4)
  List<int>? episodesSeenArray;

  DBSeasons({
    this.episodesSeen,
    this.episodes,
    this.seasonNumber,
    this.name,
    this.episodesSeenArray,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['episodesSeen'] = episodesSeen;
    data['episodes'] = episodes;
    data['seasonNumber'] = seasonNumber;
    data['name'] = name;
    data['episodesSeenArray'] = episodesSeenArray;
    return data;
  }

  @override
  String toString() => toJson().toString();
}
