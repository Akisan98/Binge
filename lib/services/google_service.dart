import 'package:googleapis/servicemanagement/v1.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class GoogleService extends IOClient {
  final Map<String, String> _headers;
  GoogleService(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url, headers: headers?..addAll(_headers));
}
