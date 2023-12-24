import 'package:dio/dio.dart';

import 'api_exception.dart';

class ApiResultInterceptor extends Interceptor {
  @override
  Future<void> onResponse(
      Response resp, ResponseInterceptorHandler handler) async {
    final result = resp.data as Map<String, dynamic>;
    if (result["code"] == 10000) {
      handler.next(resp);
      return;
    } else {
      handler.reject(
          ApiException(code: result["code"], message: result["msg"])
            ..requestOptions = resp.requestOptions,
          true);
    }
  }
}
