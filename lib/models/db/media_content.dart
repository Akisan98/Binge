import 'package:hive/hive.dart';

import '../../enums/media_type.dart';
import '../genres.dart';
import '../tmdb/tmdb_detail.dart';
import '../tv/episode_to_air.dart';
import '../tv/season.dart';
import '../v1/season.dart';
import '../v1/tv_show.dart';
import 'db_season.dart';

part 'media_content.g.dart';

@HiveType(typeId: 0)
class MediaContent {
  @HiveField(0)
  int? tmdbId;

  @HiveField(1)
  String? title;

  @HiveField(2)
  int? runtime;

  @HiveField(3)
  List<DBSeasons>? seasons;

  @HiveField(4)
  String? posterPath;

  @HiveField(5)
  List<Genres>? genres;

  @HiveField(6)
  EpisodeToAir? nextToAir;

  @HiveField(7)
  EpisodeToAir? nextToWatch;

  @HiveField(8)
  MediaType? type;

  @HiveField(9)
  String? nextRelease;

  @HiveField(10)
  String? status;

  @HiveField(11)
  bool? notificationOnly;

  MediaContent({
    this.tmdbId,
    this.title,
    this.runtime,
    this.seasons,
    this.posterPath,
    this.genres,
    this.nextToAir,
    this.nextToWatch,
    this.type,
    this.nextRelease,
    this.status,
    this.notificationOnly,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = tmdbId;
    data['title'] = title;
    data['runtime'] = runtime;
    data['seasons'] = seasons;
    data['posterPath'] = posterPath;
    data['genres'] = genres;
    data['nextToAir'] = nextToAir;
    data['nextToWatch'] = nextToWatch;
    data['type'] = type;
    data['nextRelease'] = nextRelease;
    data['status'] = status;
    data['notificationOnly'] = notificationOnly;
    return data;
  }

  @override
  String toString() => toJson().toString();

  MediaContent.fromDetails(TMDBDetail? details, String? mediaType,
      {bool? notifyOnly}) {
    tmdbId = details?.id ?? 0;
    title = details?.title;
    runtime = details?.runtime;
    seasons = toDBSeason(details?.seasons);
    posterPath = details?.posterPath;
    genres = details?.genres;
    nextToAir = details?.nextEpisodeToAir;
    nextToWatch = details?.nextEpisodeToAir;
    type = resolveType(mediaType);
    nextRelease = mediaType == MediaType.movie.string
        ? details?.releaseDate
        : details?.nextEpisodeToAir?.airDate;
    status = details?.status;
    notificationOnly = notifyOnly;
  }

  MediaType resolveType(String? type) {
    if (type == null || type == MediaType.movie.string) {
      return MediaType.movie;
    }

    return MediaType.tvSeries;
  }

  List<DBSeasons> toDBSeason(List<Seasons>? seasons) {
    final newSeasons = <DBSeasons>[];

    if (seasons == null) {
      return newSeasons;
    }

    for (var item in seasons) {
      newSeasons.add(
        DBSeasons(
          episodesSeen: 0,
          episodes: item.episodeCount,
          seasonNumber: item.seasonNumber,
          name: item.name,
        ),
      );
    }

    return newSeasons;
  }

  MediaContent.fromv1(TVShow details) {
    tmdbId = details.id ?? 0;
    title = details.title;
    runtime = details.runtime;
    seasons = toDBSeason2(details.seasons);
    posterPath = details.poster;
    type = MediaType.tvSeries;
    status = details.status;
  }

  List<DBSeasons>? toDBSeason2(List<Season>? seasons) {
    List<DBSeasons>? dbSeasons = [];

    seasons?.forEach((season) {
      DBSeasons s = DBSeasons();
      s
        ..episodesSeen = season.episodeSeen
        ..episodes = season.episodeCount
        ..seasonNumber = season.seasonNo
        ..name = season.title;

      dbSeasons.add(s);
    });

    return dbSeasons;
  }
}
