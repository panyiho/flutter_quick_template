import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_client.dart';
import 'api_result_interceptor.dart';
import 'error_interceptor.dart';
import 'mock_interceptor.dart';

class Http {
  static const Duration connectTimeout = Duration(milliseconds: 20 * 1000);
  static const Duration receiveTimeout = Duration(milliseconds: 20 * 1000);
  //change to the  real url
  static const BASE_URL = "https://xxx.com";
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  late Dio dio;
  late ApiClient _client;

  static ApiClient client() {
    return Http()._client;
  }

  Http._internal() {
    BaseOptions options = BaseOptions(
      connectTimeout: connectTimeout,
      persistentConnection: true,
      receiveTimeout: receiveTimeout,
      baseUrl: BASE_URL,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: false,
    );

    dio = Dio(options);
    //mock request ,if you want to requet you own service.must be remove
    dio.interceptors.add(MockInterceptor());
    dio.interceptors.add(ApiResultInterceptor());
    dio.interceptors.add(PrettyDioLogger(requestHeader: true));
    dio.interceptors.add(ErrorInterceptor());
    _client = ApiClient(dio, baseUrl: BASE_URL);
  }
}
