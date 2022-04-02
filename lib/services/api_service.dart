// class APIService {

//   final String _baseUrl = "http://api.themoviedb.org/3/";
// Future<dynamic> get(String url) async {
//   print('Api Get, url $url');
//   var responseJson;
//   try {
//     final response = await http.get(_baseUrl + url);
//     responseJson = _returnResponse(response);
//   } on SocketException {
//     print('No net');
//     throw FetchDataException('No Internet connection');
//   }
//   print('api get received!');
//   return responseJson;
// }
//   dynamic _returnResponse(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//       var responseJson = json.decode(response.body.toString());
//       print(responseJson);
//       return responseJson;
//     case 400:
//       throw BadRequestException(response.body.toString());
//     case 401:
//     case 403:
//       throw UnauthorizedException(response.body.toString());
//     case 500:
//     default:
//       throw FetchDataException(
//           'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
//   }
// }