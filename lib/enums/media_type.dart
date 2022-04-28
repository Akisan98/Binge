import 'package:hive/hive.dart';

part 'media_type.g.dart';

@HiveType(typeId: 4)
enum MediaType {
  @HiveField(0)
  person,

  @HiveField(1)
  movie,

  @HiveField(2)
  tvSeries
}

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
