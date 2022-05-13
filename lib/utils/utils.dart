// ignore_for_file: avoid_classes_with_only_static_members

import '../models/db/media_content.dart';

class Utils {
  static getGenre(int id) =>
      genres.firstWhere((element) => element['id'] == id)['name'];

  /// Checks whether date from API is empty or not.
  static bool isDateEmpty(String? date) => date == null || date == '';

  /// Checks if list from API is empty or not.
  static bool isListEmpty(List<dynamic>? list) => list == null || list.isEmpty;

  /// Checks if string from API is empty or not.
  static bool isStringEmpty(String? string) => string == null || string == '';

  /// Checks if number from API is empty or not.
  static bool isNumberEmpty(double? number) => number == null || number == 0;

  /// Converts the API MediaTypes into "Better" MediaTypes to display to user
  static String resolveMediaType(String? type, int? gender) {
    switch (type) {
      case 'tv':
        return 'TV Series';
      case 'person':
        return gender == 1 ? 'Actress' : 'Actor';
      case 'movie':
        return 'Movie';
      default:
        return '';
    }
  }

  static MediaContent combineMediaContents(
      MediaContent? fromDB, MediaContent live) {
    live.nextToWatch = fromDB?.nextToWatch;
    live.notificationOnly = fromDB?.notificationOnly;

    fromDB?.seasons?.forEach((element) {
      final season = (live.seasons?.firstWhere(
          (liveElement) => liveElement.seasonNumber == element.seasonNumber));

      if (element.episodesSeen != 0) {
        season?.episodesSeen =
            element.episodesSeen;
        if (season?.episodes != element.episodes) {
          final newEpisodes = (season?.episodes ?? 0) - (element.episodes ?? 0);
          for (var i = 0; i < newEpisodes; i++) {
            element.episodesSeenArray?.add(0);
          }
          season?.episodesSeenArray = element.episodesSeenArray;
        } else {
          season?.episodesSeenArray = element.episodesSeenArray;
        }
      }
    });

    return live;
  }

  // Avoid another call for string value.
  static const genres = [
    {'id': 28, 'name': 'Action'},
    {'id': 10759, 'name': 'Action & Adventure'},
    {'id': 12, 'name': 'Adventure'},
    {'id': 16, 'name': 'Animation'},
    {'id': 35, 'name': 'Comedy'},
    {'id': 80, 'name': 'Crime'},
    {'id': 99, 'name': 'Documentary'},
    {'id': 18, 'name': 'Drama'},
    {'id': 10751, 'name': 'Family'},
    {'id': 14, 'name': 'Fantasy'},
    {'id': 36, 'name': 'History'},
    {'id': 27, 'name': 'Horror'},
    {'id': 10762, 'name': 'Kids'},
    {'id': 10402, 'name': 'Music'},
    {'id': 9648, 'name': 'Mystery'},
    {'id': 10763, 'name': 'News'},
    {'id': 10764, 'name': 'Reality'},
    {'id': 10749, 'name': 'Romance'},
    {'id': 878, 'name': 'Science Fiction'},
    {'id': 10765, 'name': 'Sci-Fi & Fantasy'},
    {'id': 10766, 'name': 'Soap'},
    {'id': 10767, 'name': 'Talk'},
    {'id': 10770, 'name': 'TV Movie'},
    {'id': 53, 'name': 'Thriller'},
    {'id': 10752, 'name': 'War'},
    {'id': 10768, 'name': 'War & Politics'},
    {'id': 37, 'name': 'Western'}
  ];
}
