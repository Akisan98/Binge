import 'package:binge/models/tmdb/tmdb_credit.dart';

class TMDBSeason {
  String? sId;
  String? airDate;
  List<Episodes>? episodes;
  String? name;
  String? overview;
  int? id;
  String? posterPath;
  int? seasonNumber;

  TMDBSeason(
      {this.sId,
      this.airDate,
      this.episodes,
      this.name,
      this.overview,
      this.id,
      this.posterPath,
      this.seasonNumber});

  TMDBSeason.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    airDate = json['air_date'];
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
    name = json['name'];
    overview = json['overview'];
    id = json['id'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['air_date'] = airDate;
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['overview'] = overview;
    data['id'] = id;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    return data;
  }

  @override
  String toString() => toJson().toString();
}

class Episodes {
  String? airDate;
  int? episodeNumber;
  List<Cast>? crew;
  List<Cast>? guestStars;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  Episodes(
      {this.airDate,
      this.episodeNumber,
      this.crew,
      this.guestStars,
      this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  Episodes.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    if (json['crew'] != null) {
      crew = <Cast>[];
      json['crew'].forEach((v) {
        crew!.add(Cast.fromJson(v));
      });
    }
    if (json['guest_stars'] != null) {
      guestStars = <Cast>[];
      json['guest_stars'].forEach((v) {
        guestStars!.add(Cast.fromJson(v));
      });
    }
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
    if (crew != null) {
      data['crew'] = crew!.map((v) => v.toJson()).toList();
    }
    if (guestStars != null) {
      data['guest_stars'] = guestStars!.map((v) => v.toJson()).toList();
    }
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
}
