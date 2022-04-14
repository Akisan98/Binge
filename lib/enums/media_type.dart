enum MediaType { person, movie, tvSeries }

extension MediaTypeExtension on MediaType {
  String get string {
    switch (this) {
      case MediaType.person:
        return 'person';
      case MediaType.movie:
        return 'movie';
      case MediaType.tvSeries:
        return 'tv';
    }
  }
}
