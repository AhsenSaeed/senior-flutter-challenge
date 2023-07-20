import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hyll_ag/data/feed.dart';

class SharedWebService {
  static const String _initialPageUrl = 'https://api.hyll.com/api/adventures/';

  final HttpClient _client = HttpClient();
  final Duration _timeoutDuration = const Duration(seconds: 40);

  static SharedWebService? _instance;

  SharedWebService._();

  static SharedWebService instance() {
    _instance ??= SharedWebService._();
    return _instance!;
  }

  /// Didn't add the headers and body parameters as well to request because its just a simple get request.

  Future<HttpClientResponse> _responseFrom(Future<HttpClientRequest> Function(Uri) toCall, {required Uri uri}) =>
      toCall(uri).then((request) => request.close()).timeout(_timeoutDuration);

  Future<HttpClientResponse> _get(Uri uri) => _responseFrom(_client.getUrl, uri: uri);

  Future<HomeFeed> requestFeed({String? nextUrl}) async {
    final Uri uri = Uri.parse(nextUrl ?? _initialPageUrl);
    final response = await _get(uri);
    final responseBody = json.decode(await response.transform(utf8.decoder).join());
    return await compute(parseHomeFeed, responseBody);
  }
}

HomeFeed parseHomeFeed(dynamic responseBody) => HomeFeed.fromJson(responseBody);
