// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response-pagination-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePaginationModel _$ResponsePaginationModelFromJson(
    Map<String, dynamic> json) {
  return ResponsePaginationModel(
    page: json['page'] as int,
    totalPages: json['totalPages'] as int,
    total: json['total'] as int,
    data: json['data'],
  );
}

Map<String, dynamic> _$ResponsePaginationModelToJson(
        ResponsePaginationModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'totalPages': instance.totalPages,
      'total': instance.total,
      'data': instance.data,
    };
