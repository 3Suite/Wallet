// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return CountryModel(
    id: json['id'] as int,
    niceName: json['niceName'] as String,
    iso: json['iso'] as String,
    phoneCode: json['phoneCode'] as int,
  );
}

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'niceName': instance.niceName,
      'iso': instance.iso,
      'phoneCode': instance.phoneCode,
    };
