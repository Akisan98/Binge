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
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    id = json['id'];
    originalName = json['original_name'];
    originCountry = json['origin_country'].cast<String>();
    firstAirDate = json['first_air_date'];
    voteCount = json['vote_count'];
    name = json['name'];
    voteAverage = double.parse(json['vote_average'].toString());
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    popularity = double.parse(json['popularity'].toString());
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genre_ids'] = genreIds;
    data['original_language'] = originalLanguage;
    data['id'] = id;
    data['original_name'] = originalName;
    data['origin_country'] = originCountry;
    data['first_air_date'] = firstAirDate;
    data['vote_count'] = voteCount;
    data['name'] = name;
    data['vote_average'] = voteAverage;
    data['poster_path'] = posterPath;
    data['backdrop_path'] = backdropPath;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['media_type'] = mediaType;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
