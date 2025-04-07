import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/utils.dart';

import '../../generated/locales.g.dart';

class ApiException extends CustomDioError {
  static String CLIENT_NET_ERROR = LocaleKeys.network_network_error.tr;
  static String SERVER_NET_ERROR = LocaleKeys.network_system_error.tr;
  static String NET_CONNECT_ERROR = LocaleKeys.network_net_disconnect.tr;

  static const CODE_SUCCESS = 0;
  static const CODE_UNKNOWN = 1000;

  final int code;
  final dynamic cause;
  final String? _message;

  ApiException({
    required this.code,
    String? message,
    this.cause,
  }) : _message = message;

  @override
  String get message => _message ?? cause?.toString() ?? '';

  @override
  String toString() {
    var str = 'ApiException{code: $code, message: $message, cause: $cause}';
    if (cause != null && cause is Error) {
      str += '\n${(cause as Error).stackTrace}';
    }
    return str;
  }

  factory ApiException.create(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return BadRequestException(-1, LocaleKeys.network_request_cancel);
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return BadRequestException(-1, CLIENT_NET_ERROR);
      case DioExceptionType.receiveTimeout:
        return BadRequestException(-1, SERVER_NET_ERROR);
      case DioExceptionType.badResponse:
        try {
          int errCode = error.response!.statusCode!;
          switch (errCode) {
            case 400:
              return BadRequestException(errCode, SERVER_NET_ERROR);
            case 401:
            case 403:
            case 404:
            case 405:
            case 500:
            case 502:
            case 503:
            case 505:
              return UnauthorisedException(errCode, SERVER_NET_ERROR);
            default:
              return ApiException(
                  code: errCode, message: error.response!.statusMessage!);
          }
        } on Exception catch (_) {
          return ApiException(code: -1, message: NET_CONNECT_ERROR);
        }
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiException(code: -1, message: CLIENT_NET_ERROR);
        } else {
          return ApiException(code: -1, message: NET_CONNECT_ERROR);
        }
      default:
        return ApiException(code: -1, message: NET_CONNECT_ERROR);
    }
  }

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
      Response? response,
      DioExceptionType? type,
      Object? error,
      StackTrace? stackTrace,
      String? message}) {
    throw UnimplementedError();
  }

  @override
  DioExceptionReadableStringBuilder? stringBuilder;
}

class BadRequestException extends ApiException {
  BadRequestException([code, message]) : super(code: code, message: message);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([code, message]) : super(code: code, message: message);
}

abstract class CustomDioError implements DioException {
  static final defaultErrorRequestOptions = RequestOptions(path: '');

  @override
  String get message;

  @override
  dynamic error;

  RequestOptions _requestOptions = defaultErrorRequestOptions;

  @override
  RequestOptions get requestOptions => _requestOptions;

  @override
  set requestOptions(RequestOptions value) {
    _requestOptions = value;
  }

  @override
  Response? response;

  @override
  DioExceptionType type = DioExceptionType.unknown;

  @override
  StackTrace get stackTrace => StackTrace.current;
}
