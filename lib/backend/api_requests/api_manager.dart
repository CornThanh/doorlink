import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../flutter_flow/uploaded_file.dart';

enum ApiCallType {
  GET,
  POST,
  DELETE,
  PUT,
  PATCH,
}

enum BodyType {
  NONE,
  JSON,
  TEXT,
  X_WWW_FORM_URL_ENCODED,
  MULTIPART,
}

class ApiCallRecord extends Equatable {
  const ApiCallRecord(this.callName, this.apiUrl, this.headers, this.params,
      this.body, this.bodyType);

  final String callName;
  final String apiUrl;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;
  final String? body;
  final BodyType? bodyType;

  @override
  List<Object?> get props =>
      [callName, apiUrl, headers, params, body, bodyType];
}

class ApiCallResponse<T> {
  const ApiCallResponse(this.jsonBody, this.data, this.headers, this.statusCode,
      this.message,
      {this.response});

  final dynamic jsonBody;
  final T? data;
  final Map<String, String> headers;
  final int statusCode;
  final http.Response? response;
  final String? message;

  // Whether we received a 2xx status (which generally marks success).
  bool get succeeded => statusCode >= 200 && statusCode < 300;

  String getHeader(String headerName) => headers[headerName] ?? '';

  // Return the raw body from the response, or if this came from a cloud call
  // and the body is not a string, then the json encoded body.
  String get bodyText =>
      response?.body ?? (data is String ? data as String : jsonEncode(data));

  static ApiCallResponse<T> fromHttpResponse<T>(
    http.Response response,
    bool returnBody,
    bool decodeUtf8,
    T Function(dynamic json)? fromJson,
  ) {
    var jsonBody;
    String? message;
    try {
      final responseBody = decodeUtf8 && returnBody
          ? const Utf8Decoder().convert(response.bodyBytes)
          : response.body;
      if (responseBody.isNotEmpty) {
        jsonBody = returnBody ? json.decode(responseBody) : null;
        if (jsonBody is Map && jsonBody.containsKey('message')) {
          message = jsonBody['message'];
        }
      }
    } catch (_) {}

    T? data;
    if (jsonBody != null && fromJson != null) {
      try {
        data = jsonBody['data'] != null ? fromJson(jsonBody['data']) : null;
      } catch (_) {}
    }

    return ApiCallResponse<T>(
        jsonBody, data, response.headers, response.statusCode, message,
        response: response);
  }

  static ApiCallResponse<T> fromCloudCallResponse<T>(
      Map<String, dynamic> response, T Function(dynamic json)? fromJson) {
    var jsonBody = response['body'];
    T? data;
    String? message = response['message'];
    if (jsonBody != null && fromJson != null) {
      try {
        data = jsonBody['data'] != null ? fromJson(jsonBody['data']) : null;
      } catch (_) {}
    }
    return ApiCallResponse<T>(
        response['body'],
        data,
        ApiManager.toStringMap(response['headers'] ?? {}),
        response['statusCode'] ?? 400,
        message);
  }
}

class ApiManager {
  ApiManager._();

  // Cache that will ensure identical calls are not repeatedly made.
  static final Map<ApiCallRecord, ApiCallResponse> _apiCache = {};

  static ApiManager? _instance;

  static ApiManager get instance => _instance ??= ApiManager._();

  // If your API calls need authentication, populate this field once
  // the user has authenticated. Alter this as needed.
  static String? _accessToken;

  // You may want to call this if, for example, you make a change to the
  // database and no longer want the cached result of a call that may
  // have changed.
  static void clearCache(String callName) => _apiCache.keys
      .toSet()
      .forEach((k) => k.callName == callName ? _apiCache.remove(k) : null);

  static Map<String, String> toStringMap(Map map) =>
      map.map((key, value) => MapEntry(key.toString(), value.toString()));

  static String asQueryParams(Map<String, dynamic> map) => map.entries
      .map((e) =>
          "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}")
      .join('&');

  static Future<ApiCallResponse<T>> urlRequest<T>(
    ApiCallType callType,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    bool returnBody,
    bool decodeUtf8,
    T Function(dynamic json)? fromJson,
  ) async {
    if (params.isNotEmpty) {
      final specifier =
          Uri.parse(apiUrl).queryParameters.isNotEmpty ? '&' : '?';
      apiUrl = '$apiUrl$specifier${asQueryParams(params)}';
    }
    HttpWithMiddleware httpWithMiddleware =
        HttpWithMiddleware.build(middlewares: [
      if (kDebugMode) HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final makeRequest = callType == ApiCallType.GET
        ? httpWithMiddleware.get
        : httpWithMiddleware.delete;
    final response =
        await makeRequest(Uri.parse(apiUrl), headers: toStringMap(headers));
    return ApiCallResponse.fromHttpResponse(
        response, returnBody, decodeUtf8, fromJson);
  }

  static Future<ApiCallResponse<T>> requestWithBody<T>(
    ApiCallType type,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    String? body,
    BodyType? bodyType,
    bool returnBody,
    bool encodeBodyUtf8,
    bool decodeUtf8,
    bool alwaysAllowBody,
    T Function(dynamic json)? fromJson,
  ) async {
    assert(
      {ApiCallType.POST, ApiCallType.PUT, ApiCallType.PATCH}.contains(type) ||
          (alwaysAllowBody && type == ApiCallType.DELETE),
      'Invalid ApiCallType $type for request with body',
    );
    HttpWithMiddleware httpWithMiddleware =
        HttpWithMiddleware.build(middlewares: [
      if (kDebugMode) HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final postBody =
        createBody(headers, params, body, bodyType, encodeBodyUtf8);

    if (bodyType == BodyType.MULTIPART) {
      return multipartRequest<T>(type, apiUrl, headers, params, returnBody,
          decodeUtf8, alwaysAllowBody, fromJson);
    }

    final requestFn = {
      ApiCallType.POST: httpWithMiddleware.post,
      ApiCallType.PUT: httpWithMiddleware.put,
      ApiCallType.PATCH: httpWithMiddleware.patch,
      ApiCallType.DELETE: httpWithMiddleware.delete,
    }[type]!;
    final planets = <String, String>{'Accept': 'application/json'};
    headers.addEntries(planets.entries);
    final response = await requestFn(Uri.parse(apiUrl),
        headers: toStringMap(headers), body: postBody);
    return ApiCallResponse.fromHttpResponse(
        response, returnBody, decodeUtf8, fromJson);
  }

  static Future<ApiCallResponse<T>> multipartRequest<T>(
    ApiCallType? type,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    bool returnBody,
    bool decodeUtf8,
    bool alwaysAllowBody,
    T Function(dynamic json)? fromJson,
  ) async {
    assert(
      {ApiCallType.POST, ApiCallType.PUT, ApiCallType.PATCH}.contains(type) ||
          (alwaysAllowBody && type == ApiCallType.DELETE),
      'Invalid ApiCallType $type for request with body',
    );
    isFile(e) =>
        e is FFUploadedFile ||
        e is List<FFUploadedFile> ||
        (e is List && e.firstOrNull is FFUploadedFile);

    final nonFileParams = toStringMap(
        Map.fromEntries(params.entries.where((e) => !isFile(e.value))));

    List<http.MultipartFile> files = [];
    params.entries.where((e) => isFile(e.value)).forEach((e) {
      final param = e.value;
      final uploadedFiles = param is List
          ? param as List<FFUploadedFile>
          : [param as FFUploadedFile];
      for (var uploadedFile in uploadedFiles) {
        files.add(
          http.MultipartFile.fromBytes(
            e.key,
            uploadedFile.bytes ?? Uint8List.fromList([]),
            filename: uploadedFile.name,
            contentType: _getMediaType(uploadedFile.name),
          ),
        );
      }
    });

    final planets = <String, String>{'Accept': 'application/json'};
    headers.addEntries(planets.entries);

    HttpClientWithMiddleware httpClient =
        HttpClientWithMiddleware.build(middlewares: [
      if (kDebugMode) HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final request = http.MultipartRequest(
        type.toString().split('.').last, Uri.parse(apiUrl))
      ..headers.addAll(toStringMap(headers))
      ..files.addAll(files);
    nonFileParams.forEach((key, value) => request.fields[key] = value);

    final response =
        await http.Response.fromStream(await httpClient.send(request));
    return ApiCallResponse.fromHttpResponse<T>(
        response, returnBody, decodeUtf8, fromJson);
  }

  static MediaType? _getMediaType(String? filename) {
    final contentType = mime(filename);
    if (contentType == null) {
      return null;
    }
    final parts = contentType.split('/');
    if (parts.length != 2) {
      return null;
    }
    return MediaType(parts.first, parts.last);
  }

  static dynamic createBody(
    Map<String, dynamic> headers,
    Map<String, dynamic>? params,
    String? body,
    BodyType? bodyType,
    bool encodeBodyUtf8,
  ) {
    String? contentType;
    dynamic postBody;
    switch (bodyType) {
      case BodyType.JSON:
        contentType = 'application/json';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.TEXT:
        contentType = 'text/plain';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.X_WWW_FORM_URL_ENCODED:
        contentType = 'application/x-www-form-urlencoded';
        postBody = toStringMap(params ?? {});
        break;
      case BodyType.MULTIPART:
        contentType = 'multipart/form-data';
        postBody = params;
        break;
      case BodyType.NONE:
      case null:
        break;
    }
    // Set "Content-Type" header if it was previously unset.
    if (contentType != null &&
        !headers.keys.any((h) => h.toLowerCase() == 'content-type')) {
      headers['Content-Type'] = contentType;
    }
    return encodeBodyUtf8 && postBody is String
        ? utf8.encode(postBody)
        : postBody;
  }

  Future<ApiCallResponse<T>> makeApiCall<T>({
    required String callName,
    required String apiUrl,
    required ApiCallType callType,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> params = const {},
    String? body,
    BodyType? bodyType,
    bool returnBody = true,
    bool encodeBodyUtf8 = false,
    bool decodeUtf8 = false,
    bool cache = false,
    bool alwaysAllowBody = false,
    T Function(dynamic json)? fromJson,
  }) async {
    final callRecord =
        ApiCallRecord(callName, apiUrl, headers, params, body, bodyType);
    // Modify for your specific needs if this differs from your API.
    if (_accessToken != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $_accessToken';
    }
    // if (!apiUrl.startsWith('http')) {
    //   apiUrl = 'http://$apiUrl';
    // }

    // If we've already made this exact call before and caching is on,
    // return the cached result.
    if (cache && _apiCache.containsKey(callRecord)) {
      final cachedResponse = _apiCache[callRecord]!;
      return ApiCallResponse<T>(
        cachedResponse.jsonBody,
        cachedResponse.data,
        cachedResponse.headers,
        cachedResponse.statusCode,
        cachedResponse.message,
        response: cachedResponse.response,
      );
    }

    ApiCallResponse<T> result;
    try {
      switch (callType) {
        case ApiCallType.GET:
          result = await urlRequest(callType, apiUrl, headers, params,
              returnBody, decodeUtf8, fromJson);
          break;
        case ApiCallType.DELETE:
          result = alwaysAllowBody
              ? await requestWithBody(
                  callType,
                  apiUrl,
                  headers,
                  params,
                  body,
                  bodyType,
                  returnBody,
                  encodeBodyUtf8,
                  decodeUtf8,
                  alwaysAllowBody,
                  fromJson)
              : await urlRequest(callType, apiUrl, headers, params, returnBody,
                  decodeUtf8, fromJson);
          break;
        case ApiCallType.POST:
        case ApiCallType.PUT:
        case ApiCallType.PATCH:
          result = await requestWithBody(
              callType,
              apiUrl,
              headers,
              params,
              body,
              bodyType,
              returnBody,
              encodeBodyUtf8,
              decodeUtf8,
              alwaysAllowBody,
              fromJson);
          break;
      }

      // If caching is on, cache the result (if present).
      if (cache) {
        _apiCache[callRecord] = result;
      }
    } catch (e) {
      result = const ApiCallResponse(
        null, null, {},
        -1, null);
    }

    return result;
  }
}
