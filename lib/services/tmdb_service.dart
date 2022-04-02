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

  Future<TMDBResponse> getTrendingTVShows() async {
    const _endpoint = '/trending/tv/week';

    var request = await client.get(createUri(_endpoint, {'api_key': apiKey}));

    if (request.statusCode == 200) {
      return TMDBResponse.fromJson(jsonDecode(request.body));
    } else {
      throw Exception("Status Code on Get Trending is not 200");
    }
  }

  Future<TMDBResponse> getPopularTVShows() async {
    const _endpoint = '/tv/popular';

    var request = await client.get(createUri(_endpoint, {'api_key': apiKey}));

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
