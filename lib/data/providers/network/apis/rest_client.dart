// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:hoc24/app/logger/pretty_dio_logger.dart';

import 'exceptions/errors.dart';

class RestClient {
  static const TIMEOUT = 60000;
  static const ENABLE_LOG = true;
  static const ACCESS_TOKEN_HEADER = 'Authorization';

  // singleton
  static final RestClient instance = RestClient._internal();

  factory RestClient() {
    return instance;
  }

  RestClient._internal();

  late String baseUrl;
  late Map<String, dynamic> headers;

  void init(String baseUrl, {String? accessToken}) {
    this.baseUrl = baseUrl;
    headers = {
      'Content-Type': 'application/json',
    };
    if (accessToken != null) setToken(accessToken);
  }

  void setToken(String token) {
    headers[ACCESS_TOKEN_HEADER] = "Bearer $token";
  }

  void clearToken() {
    headers.remove(ACCESS_TOKEN_HEADER);
  }

  static Dio getDio() {
    var dio = Dio(instance.getDioBaseOption());
    if (ENABLE_LOG) {
      dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: false));
    }
    dio.interceptors.add(AppInterceptors(dio));
    return dio;
  }

  BaseOptions getDioBaseOption() {
    return BaseOptions(
      baseUrl: instance.baseUrl,
      connectTimeout: const Duration(milliseconds: TIMEOUT),
      receiveTimeout: const Duration(milliseconds: TIMEOUT),
      headers: instance.headers,
      responseType: ResponseType.json,
    );
  }
}
