// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc-short-info-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KYCShortInfoModel _$KYCShortInfoModelFromJson(Map<String, dynamic> json) {
  return KYCShortInfoModel(
    id: json['id'] as int,
    documentTypeId: json['documentTypeId'] as int,
    isApproved: json['isApproved'] as bool,
    isRejected: json['isRejected'] as bool,
    rejectReason: json['rejectReason'] as String ?? '',
    userKycId: json['userKycId'] as int,
  );
}

Map<String, dynamic> _$KYCShortInfoModelToJson(KYCShortInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentTypeId': instance.documentTypeId,
      'isApproved': instance.isApproved,
      'isRejected': instance.isRejected,
      'userKycId': instance.userKycId,
      'rejectReason': instance.rejectReason,
    };
