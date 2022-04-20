import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../enums/media_type.dart';
import '../models/tmdb/tmdb_credit.dart';
import '../models/tmdb/tmdb_detail.dart';
import '../models/tmdb/tmdb_response.dart';
import '../models/tmdb/tmdb_season.dart';

class TMDBService {
  // Base Url for the API
  static const _baseUrl = 'api.themoviedb.org';
  Uri createUri(String unencoded, Map<String, dynamic> queryParameters) =>
      Uri.https(_baseUrl, '/3$unencoded', queryParameters);

  // Image URL
  static const _thumbnailUrl = 'https://image.tmdb.org/t/p/w92';
  static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  String createImageURL(String path, bool hero) =>
      hero ? _imageUrl + path : _thumbnailUrl + path;

  // Thumbnail, 92W, 138H
  // Image, 500W, 750H
  // H is 1.5X W

  // API Key
  static String apiKey = dotenv.get('TMDB_KEY');

  // One client instance for all the requests
  Client client = Client();

  Future<TMDBDetail> getDetails(String? type, int? id) async {
    var _endpoint;
    final _id = id ?? 1;

    switch (type) {
      case 'person':
        _endpoint = '/person/$_id';
        break;
      case 'tv':
        _endpoint = '/tv/$_id';
        break;
      case 'movie':
      default:
        _endpoint = '/movie/$_id';
        break;
    }

    final uri = createUri(_endpoint, {'api_key': apiKey});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBDetail.fromJson(jsonDecode(request.body));
    } else {
      throw Exception('Status Code on Get Detail is not 200');
    }
  }

  /// Gets a Season and its Episodes of a TV Show.
  Future<TMDBSeason> getTVSeason(int showId, int season) async {
    final endpoint = '/tv/$showId/season/$season';

    final uri = createUri(endpoint, {'api_key': apiKey});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBSeason.fromJson(jsonDecode(request.body));
    } else {
      throw Exception('Status Code on Get Trending is not 200');
    }
  }

  /// Fetches Credits for selected Media from the TMDB DB.
  Future<TMDBResponse> search(String query) async {
    const _endpoint = '/search/multi';

    final uri = createUri(_endpoint, {'api_key': apiKey, 'query': query});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception('Status Code on Get Trending is not 200');
    }
  }

  /// Searches the TMDB DB for content matching query.
  Future<TMDBCredit> getCredits(int? id, String? mediaType) async {
    final _id = id ?? 1;
    var _endpoint = '/movie/$_id/credits';

    if (mediaType == MediaType.tvSeries.string) {
      _endpoint = '/tv/$_id/credits';
    }

    if (mediaType == MediaType.person.string) {
      _endpoint = '/person/$_id/combined_credits';
    }

    final uri = createUri(_endpoint, {'api_key': apiKey});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBCredit.fromJson(jsonDecode(request.body));
    } else {
      throw Exception('Status Code on Get Trending is not 200');
    }
  }

  /// Gets a list of TV Shows that is airing today.
  Future<TMDBResponse> getTodaysTVShows(int pageKey) async {
    const _endpoint = '/tv/airing_today';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final uri =
        createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(
        jsonDecode(request.body),
        MediaType.tvSeries,
      );
    } else {
      throw Exception('Status Code on Get Trending is not 200');
    }
  }

  Future<TMDBResponse> getTrendingTVShows(int pageKey) async {
    const _endpoint = '/trending/tv/week';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final uri =
        createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(
        jsonDecode(request.body),
        MediaType.tvSeries,
      );
    } else {
      throw Exception('Status Code on Get Trending is not 200');
    }
  }

  Future<TMDBResponse> getPopularTVShows(int pageKey) async {
    const _endpoint = '/tv/popular';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final request = await client.get(
      createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()}),
    );

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(
        jsonDecode(request.body),
        MediaType.tvSeries,
      );
    } else {
      throw Exception('Status Code on Get Popular is not 200');
    }
  }

  Future<TMDBResponse> getCurrentMovies(int pageKey) async {
    const _endpoint = '/movie/now_playing';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final request = await client.get(
      createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()}),
    );

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body), MediaType.movie);
    } else {
      throw Exception('Status Code on Get Popular is not 200');
    }
  }

  Future<TMDBResponse> getTopRatedMovies(int pageKey) async {
    const _endpoint = '/movie/top_rated';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final request = await client.get(
      createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()}),
    );

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body), MediaType.movie);
    } else {
      throw Exception('Status Code on Get Popular is not 200');
    }
  }

  Future<TMDBResponse> getPopularMovies(int pageKey) async {
    const _endpoint = '/movie/popular';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final request = await client.get(
      createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()}),
    );

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body), MediaType.movie);
    } else {
      throw Exception('Status Code on Get Popular is not 200');
    }
  }
}
