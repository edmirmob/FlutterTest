import 'dart:convert';

import 'package:http/http.dart' as baseHttp;

mixin Http {
  Future<T> get<T>(String url) async {
    return baseHttp
        .get(
      Uri.parse(url),
    )
        .then((response) {
      if (response.statusCode == 204) {
        throw HttpException('${response.statusCode}');
      }
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }
      bool isJson =
          response.headers['content-type']!.contains('application/json;');

      return isJson ? jsonDecode(response.body) as T : response.body as T;
    });
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() {
    return message;
  }
}
