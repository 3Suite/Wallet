// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    phone: json['phone'] as String ?? '',
    email: json['email'] as String ?? '',
    firstName: json['firstName'] as String ?? '',
    secondName: json['secondName'] as String ?? '',
    countryId: json['countryId'] as int,
    city: json['city'] as String ?? '',
    address: json['address'] as String ?? '',
    birthDate: json['birthDate'] as String ?? '',
    refNumber: json['refNumber'] as String ?? '',
    serviceLevel: json['serviceLevel'] as int,
    approvedAt: json['approvedAt'] as String,
    rejectedAt: json['rejectedAt'] as String,
    rejectedReason: json['rejectedReason'] as String,
  )..bankDetails = UserModel._bankDetailsFromJson(
      json['bankDetails'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'countryId': instance.countryId,
      'city': instance.city,
      'address': instance.address,
      'birthDate': instance.birthDate,
      'refNumber': instance.refNumber,
      'bankDetails': instance.bankDetails,
      'serviceLevel': instance.serviceLevel,
      'approvedAt': instance.approvedAt,
      'rejectedAt': instance.rejectedAt,
      'rejectedReason': instance.rejectedReason,
    };
