import 'package:hive/hive.dart';

part 'episode_to_air.g.dart';

@HiveType(typeId: 3)
class EpisodeToAir {
  @HiveField(0)
  String? airDate;

  @HiveField(1)
  int? episodeNumber;

  @HiveField(2)
  int? id;

  @HiveField(3)
  String? name;

  @HiveField(4)
  String? overview;

  @HiveField(5)
  String? productionCode;

  @HiveField(6)
  int? seasonNumber;

  @HiveField(7)
  String? stillPath;

  @HiveField(8)
  double? voteAverage;

  @HiveField(9)
  int? voteCount;

  EpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  EpisodeToAir.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    seasonNumber = json['season_number'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['season_number'] = seasonNumber;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  @override
  String toString() => toJson().toString();
}
