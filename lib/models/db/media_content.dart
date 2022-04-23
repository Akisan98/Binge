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
