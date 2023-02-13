import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable(
    genericArgumentFactories: true,
    fieldRename: FieldRename.snake,
    nullable: true)
class BaseResponse<T> {
  @JsonKey(name: 'data')
  final T? data;
  @JsonKey(name: 'message')
  final String? message;
  BaseResponse(this.data, this.message);
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
