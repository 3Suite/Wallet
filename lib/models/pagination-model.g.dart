// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) {
  return PaginationModel(
    page: json['page'] as int,
    size: json['size'] as int,
    type: json['type'] as int,
    filter: json['filter'] == null
        ? null
        : TransactionsFilter.fromJson(json['filter'] as Map<String, dynamic>),
    sort: (json['sort'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('size', instance.size);
  writeNotNull('type', instance.type);
  writeNotNull('filter', PaginationModel._filterToJson(instance.filter));
  writeNotNull('sort', instance.sort);
  return val;
}
