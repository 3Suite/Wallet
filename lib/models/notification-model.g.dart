// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    id: json['id'] as int,
    message: json['message'] as String,
    subject: json['subject'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'subject': instance.subject,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
