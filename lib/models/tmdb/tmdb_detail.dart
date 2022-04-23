import '../companies.dart';
import '../genres.dart';
import '../tv/episode_to_air.dart';
import '../tv/season.dart';

class TMDBDetail {
  bool? adult;
  String? backdropPath;
  // BelongsToCollection? belongsToCollection; What Franchise
  int? budget; // Movie
  // TV
  // List<CreatedBy>? createdBy; - Director
  //List<int>? episodeRunTime; // Movie - Runtime
  // TV
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId; // Movie

  // TV
  bool? inProduction;
  // List<String>? languages;
  String? lastAirDate;
  EpisodeToAir? lastEpisodeToAir;
  EpisodeToAir? nextEpisodeToAir;
  List<Companies>? companies; // Movie - productionCompanies
  int? numberOfEpisodes;
  int? numberOfSeasons;
  // List<String>? originCountry;
  // TV

  //String? originalLanguage;
  //String? originalTitle; // TV - Name
  String? overview;
  double? popularity;
  String? posterPath;
  //List<ProductionCountries>? productionCountries;
  List<Seasons>? seasons; // TV
  String? releaseDate; // TV - firstAirDate
  int? revenue;
  int? runtime;
  //List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title; // TV - name
  bool? video; // Movie - Trailer
  // String? type; // TV
  double? voteAverage;
  int? voteCount;

  // Person
  String? birthday;
  String? deathday;

  TMDBDetail({
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.inProduction,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.nextEpisodeToAir,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.overview,
    this.popularity,
    this.posterPath,
    this.companies,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  TMDBDetail.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    overview = json['overview'] ?? json['biography'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['networks'] != null) {
      companies = <Companies>[];
      json['networks'].forEach((v) {
        companies!.add(Companies.fromJson(v));
      });
    }
    if (json['production_companies'] != null) {
      companies = <Companies>[];
      json['production_companies'].forEach((v) {
        companies!.add(Companies.fromJson(v));
      });
    }
    lastAirDate = json['last_air_date'];
    lastEpisodeToAir = json['last_episode_to_air'] != null
        ? EpisodeToAir.fromJson(json['last_episode_to_air'])
        : null;
    nextEpisodeToAir = json['next_episode_to_air'] != null
        ? EpisodeToAir.fromJson(json['next_episode_to_air'])
        : null;
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(Seasons.fromJson(v));
      });
    }
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    inProduction = json['in_production'];
    releaseDate = json['release_date'] ?? json['first_air_date'];
    revenue = json['revenue'];
    runtime = getRuntime(json);
    status = json['status'];
    tagline = json['tagline'] ?? json['place_of_birth'];
    title = json['title'] ?? json['name'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    birthday = json['birthday'];
    deathday = json['deathday'];
  }

  /// Gets the runtime for selected media.
  int? getRuntime(Map<String, dynamic> json) {
    if (json['runtime'] != null) {
      return json['runtime'];
    }
    if (json['episode_run_time'] != null) {
      final List<int>? list = json['episode_run_time'].cast<int>();

      if (list != null && list.isNotEmpty) {
        return list.first;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    // TODO: Fix or Remove.
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    if (companies != null) {
      data['production_companies'] = companies!.map((v) => v.toJson()).toList();
    }
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
