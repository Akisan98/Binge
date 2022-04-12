class TMDBResults {
  List<int>? genreIds;
  String? originalLanguage;
  int? id;
  String? originalName;
  List<String>? originCountry;
  String? firstAirDate;
  int? voteCount;
  String? name;
  double? voteAverage;
  String? posterPath;
  String? backdropPath;
  String? overview;
  double? popularity;
  String? mediaType;

  // Actors
  bool? adult;
  int? gender;
  List<TMDBResults>? knownFor;
  // String? knownForDepartment;

  TMDBResults(
      {this.genreIds,
      this.originalLanguage,
      this.id,
      this.originalName,
      this.originCountry,
      this.firstAirDate,
      this.voteCount,
      this.name,
      this.voteAverage,
      this.posterPath,
      this.backdropPath,
      this.overview,
      this.popularity,
      this.mediaType});

  TMDBResults.fromJson(Map<String, dynamic> json) {
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : null;
    originalLanguage = json['original_language'];
    id = json['id'];
    originalName = json['original_name'] ?? json['original_title'];
    originCountry = json['origin_country'] != null
        ? json['origin_country'].cast<String>()
        : null;
    firstAirDate = json['first_air_date'] ?? json['release_date'];
    voteCount = json['vote_count'];
    name = json['name'] ?? json['title'];
    voteAverage = json['vote_average'] != null
        ? double.parse(json['vote_average'].toString())
        : null;
    posterPath = json['poster_path'] ?? json['profile_path'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    popularity = json['popularity'] != null
        ? double.parse(json['popularity'].toString())
        : null;
    mediaType = json['media_type'];
    adult = json['adult'];
    gender = json['gender'];
    // knownForDepartment = json['known_for_department'];

    if (json['known_for'] != null) {
      knownFor = <TMDBResults>[];
      json['known_for'].forEach((v) {
        knownFor!.add(new TMDBResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'genre_ids': genreIds,
        'original_language': originalLanguage,
        'id': id,
        'original_name': originalName,
        'origin_country': originCountry,
        'first_air_date': firstAirDate,
        'vote_count': voteCount,
        'name': name,
        'vote_average': voteAverage,
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
        'overview': overview,
        'popularity': popularity,
        'media_type': mediaType,
        'adult': adult,
        'gender': gender,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
