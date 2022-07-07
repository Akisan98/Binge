/// Data class for infomation about Episode
class Episode {
  /// Unique Episode ID
  final int? id;

  /// Name of Episode - original_name
  final String? title;

  /// Which Season this Episode is a part of.
  final int? seasonNo;

  /// Which Episode number it has in the Season.
  final int? episodeNo;

  /// When the Episode was aired / released.
  final String? airDate;

  /// The Unique ID for the TVShow this Episode is a part of.
  final int? showID;

  /// A summary of the Episode - Overview
  final String? summary;

  /// A image of the Episode usually a screen grab - still_path
  final String? image;

  /// The rating of this Episode - vote_average
  final double? rating;

  /// Constructor for Episode
  Episode(
    this.id,
    this.title,
    this.seasonNo,
    this.episodeNo,
    this.airDate,
    this.showID,
    this.summary,
    this.image,
    this.rating,
  );

  /// Method for creating Episode from JSON.
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      json['id'],
      json['name'],
      json['season_number'],
      json['episode_number'],
      json['air_date'],
      json['show_id'],
      json['overview'],
      json['still_path'],
      json['vote_average'],
    );
  }

  /// Method for creating JSON for storing in DB.
  Map<String, dynamic> toDBJson() => {
        'id': id,
        'title': title,
        'season_number': seasonNo,
        'episode_number': episodeNo,
        'air_date': airDate,
        'show_id': showID,
        'summary': summary,
        'image': image,
        'rating': rating
      };

  /// Method for creating Episode from JSON.
  Episode.fromDBJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        seasonNo = json['season_number'],
        episodeNo = json['episode_number'],
        airDate = json['air_date'],
        showID = json['show_id'],
        summary = json['summary'],
        image = json['image'],
        rating = json['rating'];

  @override
  String toString() {
    return toDBJson().toString();
  }
}
