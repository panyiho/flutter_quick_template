import 'package:json_annotation/json_annotation.dart';
import 'api_exception.dart';
part 'result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  int code;
  T? data;
  String? msg;

  Result({required this.code, this.data, this.msg});

  factory Result.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$ResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ResultToJson(this, toJsonT);

  factory Result.fromMapJson(Map<String, dynamic> json) {
    return Result(
      code: json['code'] as int,
      data: json['data'] as T?,
      msg: json['msg'] as String?,
    );
  }

  ApiException toException({dynamic cause}) =>
      ApiException(code: code, message: msg, cause: cause);
}
