// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:dio/dio.dart';

class AppInterceptors extends InterceptorsWrapper {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var messageError;
    try {
      messageError = jsonDecode(err.response.toString())['message'] ?? jsonDecode(err.response.toString())['error'];
    } catch (e) {
      messageError = null;
    }
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, message: messageError);
          case 401:
            throw UnauthorizedException(err.requestOptions, message: messageError);
          case 404:
            throw NotFoundException(err.requestOptions, message: messageError);
          case 409:
            throw ConflictException(err.requestOptions, message: messageError);
          case 500:
            throw InternalServerErrorException(err.requestOptions, message: messageError);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions, message: messageError);
    }
    return handler.next(err);
  }
}

class BadRequestException extends DioException {
  final String? messageError;

  BadRequestException(RequestOptions r, {message})
      : messageError = message is String ? message : message[0],
        super(requestOptions: r);

  @override
  String toString() {
    return messageError != null ? messageError.toString() : 'Invalid document';
  }
}

class InternalServerErrorException extends DioException {
  final String? messageError;

  InternalServerErrorException(RequestOptions r, {message})
      : messageError = message is String ? message : message[0],
        super(requestOptions: r);

  @override
  String toString() {
    return messageError != null ? messageError.toString() : 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  final String? messageError;

  ConflictException(RequestOptions r, {message})
      : messageError = message is String ? message : message[0],
        super(requestOptions: r);

  @override
  String toString() {
    return messageError != null ? messageError.toString() : 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  final String? messageError;

  UnauthorizedException(RequestOptions r, {message})
      : messageError = message is String ? message : message[0],
        super(requestOptions: r);

  @override
  String toString() {
    return messageError != null ? messageError.toString() : 'Access denied';
  }
}

class NotFoundException extends DioException {
  final String? messageError;

  NotFoundException(RequestOptions r, {message})
      : messageError = message is String ? message : message[0],
        super(requestOptions: r);

  @override
  String toString() {
    return messageError != null ? messageError.toString() : 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  final String? messageError;

  NoInternetConnectionException(RequestOptions r, {message})
      : messageError = message != null ? (message is String ? message : message[0]) : null,
        super(requestOptions: r);

  @override
  String toString() {
    return messageError != null ? messageError.toString() : 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  final String? messageError;

  DeadlineExceededException(RequestOptions r, {message})
      : messageError = message is String ? message : message[0],
        super(requestOptions: r);

  @override
  String toString() {
    return messageError != null ? messageError.toString() : 'The connection has timed out, please try again.';
  }
}
