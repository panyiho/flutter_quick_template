import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'result.dart';
import 'test_info.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/info")
  Future<Result<TestInfo>> getInfo();
}
