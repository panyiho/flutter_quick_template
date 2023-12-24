import 'package:dio/dio.dart';
import 'api_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var apiException = err;

    if (err is! ApiException) {
      apiException = ApiException.create(err);
    }

    super.onError(apiException, handler);
  }
}
