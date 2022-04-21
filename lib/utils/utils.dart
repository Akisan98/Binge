class Utils {
  isEmptyOrNull(input) {
    if (input == null || input?.length == 0 || input == '') return true;
    return false;
  }

  getGenre(int id) {
    return genres.firstWhere((element) => element['id'] == id)['name'];
  }

  isListEmpty(List<dynamic>? list) {
    return list == null || list.isEmpty;
  }

  static bool isStringEmpty(String? string) {
    if (string == null || string == '') {
      return true;
    }

    return false;
  }

  bool isNullOrEmpty(double? number) {
    if (number == null || number == 0) {
      return true;
    }

    return false;
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
