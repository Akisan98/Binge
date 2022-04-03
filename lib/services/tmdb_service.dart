import 'dart:convert';
import 'dart:developer';

import 'package:binge/models/tmdb_response.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TMDBService {
  // Base Url for the API
  static const _baseUrl = 'api.themoviedb.org';
  Uri createUri(String unencoded, Map<String, dynamic> queryParameters) =>
      Uri.https(_baseUrl, '/3$unencoded', queryParameters);

  // Image URL
  static const _imageUrl = 'https://image.tmdb.org/t/p/w92';
  String createImageURL(String path) => _imageUrl + path;

  // API Key
  static String apiKey = dotenv.get('TMDB_KEY');

  // One client instance for all the requests
  Client client = Client();

  // search(String query) {
  //   var _searchEndpoint = '/search/multi?api_key=$apiKey&query=$query';

  //   client.get(createUri(_searchEndpoint));
  // }

  /// Gets a list of TV Shows that is airing today.
  Future<TMDBResponse> getTodaysTVShows(int pageKey) async {
    const _endpoint = '/tv/airing_today';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception("Page Key out of range!");
    }

    var uri =
        createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()});
    log(uri.toString());
    var request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Status Code on Get Trending is not 200");
    }
  }

  Future<TMDBResponse> getTrendingTVShows(int pageKey) async {
    const _endpoint = '/trending/tv/week';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception("Page Key out of range!");
    }

    var uri =
        createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()});
    log(uri.toString());
    var request = await client.get(uri);

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Status Code on Get Trending is not 200");
    }
  }

  Future<TMDBResponse> getPopularTVShows(int pageKey) async {
    const _endpoint = '/tv/popular';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception("Page Key out of range!");
    }

    var request = await client.get(
        createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()}));

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Status Code on Get Popular is not 200");
    }
  }

  Future<TMDBResponse> getCurrentMovies(int pageKey) async {
    const _endpoint = '/movie/now_playing';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception("Page Key out of range!");
    }

    var request = await client.get(
        createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()}));

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Status Code on Get Popular is not 200");
    }
  }

  Future<TMDBResponse> getTopRatedMovies(int pageKey) async {
    const _endpoint = '/movie/top_rated';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception("Page Key out of range!");
    }

    var request = await client.get(
        createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()}));

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Status Code on Get Popular is not 200");
    }
  }

  Future<TMDBResponse> getPopularMovies(int pageKey) async {
    const _endpoint = '/movie/popular';

    // Max range in docs
    if (pageKey <= 0 || pageKey > 1000) {
      throw Exception("Page Key out of range!");
    }

    var request = await client.get(
        createUri(_endpoint, {'api_key': apiKey, 'page': pageKey.toString()}));

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Status Code on Get Popular is not 200");
    }
  }

  decodeBody(Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> items = json['results'];
      return items;
    } else {
      return response;
    }
  }
}
