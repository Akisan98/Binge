import '../../enums/media_type.dart';
import 'tmdb_result.dart';

class TMDBResponse {
  int? page;
  List<TMDBResults>? results;
  int? totalPages;
  int? totalResults;

  TMDBResponse({this.page, this.results, this.totalPages, this.totalResults});

  TMDBResponse.fromJson(Map<String, dynamic> json, [MediaType? type]) {
    page = json['page'];
    if (json['results'] != null) {
      results = <TMDBResults>[];
      json['results'].forEach((v) {
        var item = TMDBResults.fromJson(v);
        if (type != null) {
          item.mediaType = type.string;
        }
        results!.add(item);
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
