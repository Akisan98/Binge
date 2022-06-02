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
import '../models/tv/episode_to_air.dart';

class TMDBService {
  // Base Url for the API
  static const _baseUrl = 'api.themoviedb.org';
  Uri createUri(String unencoded, Map<String, dynamic> queryParameters) =>
      Uri.https(_baseUrl, '/3$unencoded', queryParameters);

  // API Key
  static String apiKey = dotenv.get('TMDB_KEY');

  // One client instance for all the requests
  Client client = Client();

  Future<TMDBDetail> getDetails(String? type, int? tmdbId) async {
    String endpoint;
    final id = tmdbId;

    switch (type) {
      case 'person':
        endpoint = '/person/$id';
        break;
      case 'tv':
        endpoint = '/tv/$id';
        break;
      case 'movie':
      default:
        endpoint = '/movie/$id';
        break;
    }

    final uri = createUri(endpoint, {'api_key': apiKey});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      //log(request.body);
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

  /// Gets a Season and its Episodes of a TV Show.
  Future<EpisodeToAir> getTVSeason2(int showId, int season, int episode) async {
    final endpoint = '/tv/$showId/season/$season/episode/$episode';

    final uri = createUri(endpoint, {'api_key': apiKey});
    //log(uri.toString());
    final request = await client.get(uri);

    //log(jsonDecode(request.body).toString());

    if (request.statusCode == 200) {
      return EpisodeToAir.fromJson(jsonDecode(request.body));
    } else {
      throw Exception('Status Code on Season is not 200');
    }
  }

  /// Fetches Credits for selected Media from the TMDB DB.
  Future<TMDBResponse> search(String query) async {
    const endpoint = '/search/multi';

    final uri = createUri(endpoint, {'api_key': apiKey, 'query': query});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception('Status Code on Search is not 200');
    }
  }

  /// Searches the TMDB DB for content matching query.
  Future<TMDBCredit> getCredits(int? tmdbId, String? mediaType) async {
    final id = tmdbId;
    var endpoint = '/movie/$id/credits';

    if (mediaType == MediaType.tvSeries.string) {
      endpoint = '/tv/$id/credits';
    }

    if (mediaType == MediaType.person.string) {
      endpoint = '/person/$id/combined_credits';
    }

    final uri = createUri(endpoint, {'api_key': apiKey});
    log(uri.toString());
    final request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBCredit.fromJson(jsonDecode(request.body));
    } else {
      throw Exception('Status Code on Get Credit is not 200');
    }
  }

  /// Gets a list of TV Shows that is airing today.
  Future<TMDBResponse> getTodaysTVShows(int pageKey) async {
    const endpoint = '/tv/airing_today';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final uri =
        createUri(endpoint, {'api_key': apiKey, 'page': pageKey.toString()});
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
    const endpoint = '/trending/tv/week';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final uri =
        createUri(endpoint, {'api_key': apiKey, 'page': pageKey.toString()});
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
    const endpoint = '/tv/popular';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final request = await client.get(
      createUri(endpoint, {'api_key': apiKey, 'page': pageKey.toString()}),
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
    const endpoint = '/movie/now_playing';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final request = await client.get(
      createUri(endpoint, {'api_key': apiKey, 'page': pageKey.toString()}),
    );

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body), MediaType.movie);
    } else {
      throw Exception('Status Code on Get Popular is not 200');
    }
  }

  Future<TMDBResponse> getTopRatedMovies(int pageKey) async {
    const endpoint = '/movie/top_rated';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final request = await client.get(
      createUri(endpoint, {'api_key': apiKey, 'page': pageKey.toString()}),
    );

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body), MediaType.movie);
    } else {
      throw Exception('Status Code on Get Popular is not 200');
    }
  }

  Future<TMDBResponse> getPopularMovies(int pageKey) async {
    const endpoint = '/movie/popular';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception('Page Key out of range!');
    }

    final request = await client.get(
      createUri(endpoint, {'api_key': apiKey, 'page': pageKey.toString()}),
    );

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body), MediaType.movie);
    } else {
      throw Exception('Status Code on Get Popular is not 200');
    }
  }
}
