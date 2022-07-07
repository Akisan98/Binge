import 'episode.dart';

/// Data class for infomation about Season
class Season {
  //String _id;

  /// Unique Season ID
  final int? id;

  /// The Unique ID for the TVShow this Season is a part of.
  final int? showID;

  /// Name of Season - Season 1
  final String? title;

  //final String summary;
  //final String poster;

  /// Which Season this is.
  final int? seasonNo;

  /// When the Season was aired / released.
  final String? airDate;

  /// List of all Episodes in the Season
  List<Episode>? episodes;

  /// Number of Episode in the Season
  final int? episodeCount;

  /// How many Episode of the Season that are seen.
  int? episodeSeen = 0;
  // TODO: OUT OF ORDER
  /// How many Episode of the Season that are seen.
  //List<bool>? seenList;

  /// Constructor for Season
  Season(this.id, this.showID, this.title, this.seasonNo, this.airDate,
      this.episodeCount, this.episodeSeen);

  /// Constructor for Extended Season
  Season.extended(
    this.id,
    this.showID,
    this.title,
    this.seasonNo,
    this.airDate,
    this.episodes, // The Big Difference
    this.episodeCount,
  );

  /// Method for creating Season from JSON.
  factory Season.fromJsonE(Map<String, dynamic> json, showID) {
    // ignore: omit_local_variable_types
    List<Episode> epis = [];

    List<dynamic> episodesRAW = json['episodes'];
    for (var episode in episodesRAW) {
      epis.add(Episode(
        episode['id'],
        episode['name'],
        episode['season_number'],
        episode['episode_number'],
        episode['air_date'],
        episode['show_id'],
        episode['overview'],
        episode['still_path'],
        episode['vote_average'],
      ));
    }
    /*episodesRAW.forEach((episode) { 
    });*/

    return Season.extended(
      json['id'],
      showID,
      json['name'],
      json['season_number'],
      json['air_date'],
      epis,
      epis.length,
    );
  }

  /// Method for creating JSON for storing in DB.
  Map<String, dynamic> toDBJson() => {
        'id': id,
        'show_id': showID,
        'title': title,
        'season_number': seasonNo,
        'air_date': airDate,
        'episode_count': episodeCount,
        'episodes_seen': episodeSeen
      };

  /// Method for creating Season from JSON.
  Season.fromDBJson(Map<String, dynamic> json)
      : id = json['id'],
        showID = json['show_id'],
        title = json['title'],
        seasonNo = json['season_number'],
        airDate = json['air_date'],
        episodeCount = json['episode_count'],
        episodeSeen = json['episodes_seen'];

  @override
  String toString() {
    return toDBJson().toString();
  }
}
