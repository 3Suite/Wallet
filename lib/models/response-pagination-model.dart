import 'package:json_annotation/json_annotation.dart';

part 'response-pagination-model.g.dart';

@JsonSerializable()
class ResponsePaginationModel {
  int page;
  int totalPages;
  int total;
  dynamic data;

  ResponsePaginationModel({this.page, this.totalPages, this.total, this.data});

  factory ResponsePaginationModel.fromJson(Map<String, dynamic> json) => _$ResponsePaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsePaginationModelToJson(this);
}
