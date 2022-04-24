import '../../enums/media_type.dart';
import '../genres.dart';
import '../tmdb/tmdb_detail.dart';
import '../tv/episode_to_air.dart';
import '../tv/season.dart';

class DBSeasons {
  int? episodesSeen;
  int? episodes;
  int? seasonNumber;
  String? name;
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

class MediaContent {
  String? title;
  int? runtime;
  List<DBSeasons>? seasons;
  String? posterPath;
  List<Genres>? genres;
  EpisodeToAir? nextToAir;
  EpisodeToAir? nextToWatch;
  MediaType? type;

  MediaContent({
    this.title,
    this.runtime,
    this.seasons,
    this.posterPath,
    this.genres,
    this.nextToAir,
    this.nextToWatch,
    this.type,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['runtime'] = runtime;
    data['seasons'] = seasons;
    data['posterPath'] = posterPath;
    data['genres'] = genres;
    data['nextToAir'] = nextToAir;
    data['nextToWatch'] = nextToWatch;
    data['type'] = type;
    return data;
  }

  @override
  String toString() => toJson().toString();

  MediaContent.fromDetails(TMDBDetail? details) {
    title = details?.title;
    runtime = details?.runtime;
    seasons = toDBSeason(details?.seasons);
    posterPath = details?.posterPath;
    genres = details?.genres;
    nextToAir = details?.nextEpisodeToAir;
    nextToWatch = details?.nextEpisodeToAir;
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

  
}
