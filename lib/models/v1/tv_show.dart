import 'dart:convert';

import 'episode.dart';
import 'season.dart';

/// Data class for infomation about TVShow
class TVShow {
  /// Unique TVShow ID
  final int? id;

  /// Name of TVShow - original_name
  final String? title;

  /// URL to Poster image of the TVShow
  final String? poster;

  /// URL to Banner image of the TVShow
  final String? backdrop;

  /// A summary of the TVShow - Overview
  final String? summary;

  /// How long a Episode lasts - episode_run_time
  int? runtime;

  /// When the TVShow was aired / released - first_air_date
  String? firstAirDate;

  /// The Genres of the TVShow
  List<String?>? genre;

  /// Whther the TVShow is in production or not.
  bool? inProduction;

  /// Date of the last Episode aired / released.
  String? lastAiredDate;

  /// The latest Episode to air / release.
  Episode? lastEpisodeToAir;

  /// The next Episode to air / release.
  Episode? nextEpisodeToAir;

  /// Number of Episodes in the TVShow in total.
  int? numberOfEpisodes;

  /// Number of Season in the TVShow.
  int? numberOfSeasons;

  /// List of all Seasons in the TVShow
  List<Season>? seasons;

  /// The Status of the TVShow - Returing Series, Canceled / Ended
  String? status;

  /// The rating of this TVShow - vote_average
  double? rating;

  /// The next Episode to watch - Episode in JSON Format
  String? nextToWatch;

  // Popular, Search - id, title, poster, backdrop, summary || TVShow
  // DetailScreen - id, title, poster, backdrop, summary
  // + episode_run_time || TVShow.extended

  /// Constructor for TVShow
  TVShow(
    this.id,
    this.title,
    this.poster,
    this.backdrop,
    this.summary,
  );

  /// Method for creating TVShow from JSON.
  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(json['id'], json['original_name'], json['poster_path'],
        json['backdrop_path'], json['overview']);
  }

  /// Constructor for Extended TVShow
  TVShow.extended(
    this.id,
    this.title,
    this.poster,
    this.backdrop,
    this.summary,
    this.runtime,
    this.firstAirDate,
    this.genre,
    // ignore: avoid_positional_boolean_parameters
    this.inProduction,
    this.lastAiredDate,
    this.lastEpisodeToAir,
    this.nextEpisodeToAir,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.seasons,
    this.status,
    this.rating,
  );

  /// Method for creating TVShow from JSON.
  factory TVShow.fromJsonE(Map<String, dynamic> json) {
    // Based on Assumtion that TV Shows are between 25 - 60 min
    // ignore: omit_local_variable_types
    int? episodeRuntime = 25;

    // ignore: lines_longer_than_80_chars
    if (json['episode_run_time'] != null &&
        json['episode_run_time'].toString() != '[]') {
      episodeRuntime = json['episode_run_time'][0];
    }

    // ignore: omit_local_variable_types
    List<String?> genres = [];
    List<dynamic> genresRAW = json['genres'];
    for (var genre in genresRAW) {
      genres.add(genre['name']);
    }
    /*genresRAW.forEach((genre) {
    });*/

    Episode? lastEpisodeToAir;
    if (json['last_episode_to_air'] != null) {
      lastEpisodeToAir = Episode(
        json['last_episode_to_air']['id'],
        json['last_episode_to_air']['name'],
        json['last_episode_to_air']['season_number'],
        json['last_episode_to_air']['episode_number'],
        json['last_episode_to_air']['air_date'],
        json['last_episode_to_air']['show_id'],
        json['last_episode_to_air']['overview'],
        json['last_episode_to_air']['still_path'],
        json['last_episode_to_air']['vote_average'],
      );
    }

    Episode? nextEpisodeToAir;
    if (json['next_episode_to_air'] != null) {
      nextEpisodeToAir = Episode(
        json['next_episode_to_air']['id'],
        json['next_episode_to_air']['name'],
        json['next_episode_to_air']['season_number'],
        json['next_episode_to_air']['episode_number'],
        json['next_episode_to_air']['air_date'],
        json['next_episode_to_air']['show_id'],
        json['next_episode_to_air']['overview'],
        json['next_episode_to_air']['still_path'],
        json['next_episode_to_air']['vote_average'],
      );
    }

    // ignore: omit_local_variable_types
    List<Season> seasons = [];
    List<dynamic> seasonsRAW = json['seasons'];

    for (var season in seasonsRAW) {
      if (season['season_number'] != 0) {
        seasons.add(Season(
            season['id'],
            json['id'],
            season['name'],
            season['season_number'],
            season['air_date'],
            season['episode_count'],
            0));
      }
    }

    return TVShow.extended(
      json['id'],
      json['original_name'],
      json['poster_path'],
      json['backdrop_path'],
      json['overview'],
      episodeRuntime,
      json['first_air_date'],
      genres,
      json['in_production'],
      json['last_air_date'],
      lastEpisodeToAir,
      nextEpisodeToAir,
      json['number_of_episodes'],
      json['number_of_seasons'],
      seasons,
      json['status'],
      json['vote_average'],
    );
  }

  /// Converts the List of Seasons into JSON for DB Storage
  String encodeSeasonsArray() {
    return jsonEncode(seasons!.map((season) => season.toDBJson()).toList());
  }

  /// Converts TVShow into JSON for DB Storage
  String? encodeEpisode() {
    return nextEpisodeToAir == null
        ? null
        : jsonEncode(nextEpisodeToAir!.toDBJson());
  }

  /// Converts Episode into JSON for DB Storage
  Map<String, dynamic> toDB() => {
        'show_id': id,
        'show_title': title,
        'poster_path': poster,
        'backdrop_path': backdrop,
        'summary': summary,
        'show_runtime': runtime,
        'number_of_episodes': numberOfEpisodes,
        'seasons_lists': encodeSeasonsArray(),
        'show_status': status,
        'next_watch': nextToWatch,
        'next_air': encodeEpisode(),
        'next_air_date': nextEpisodeToAir == null
            ? null
            : nextEpisodeToAir!.airDate, // Needed for DB sort by date
      };

  /// Converts TVShow from JSON used for DB Retrival
  TVShow.fromDB(Map<String, dynamic> json)
      : id = json['show_id'],
        title = json['show_title'],
        poster = json['poster_path'],
        backdrop = json['backdrop_path'],
        summary = json['summary'],
        runtime = json['show_runtime'],
        numberOfEpisodes = json['number_of_episodes'],
        seasons = jsonDecode(json['seasons_lists']).map<Season>((season) {
          return Season.fromDBJson(season);
        }).toList(),
        status = json['show_status'],
        nextToWatch = json['next_watch'],
        nextEpisodeToAir = json['next_air'] == null
            ? null
            : Episode.fromDBJson(jsonDecode(json['next_air']));
}
