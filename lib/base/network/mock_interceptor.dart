import 'dart:convert';

import 'package:dio/dio.dart';

class MockInterceptor extends Interceptor {
  String jsonString =
      '''
    {
        "code": 10000,
        "msg": "success",
        "data": {"age":22}
    }
  ''';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.resolve(
        Response(requestOptions: options, data: jsonDecode(jsonString)), true);
  }
}
