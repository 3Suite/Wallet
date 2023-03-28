import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification-model.g.dart';

@JsonSerializable()
class NotificationModel {
  int id;
  String message;
  String subject;
  DateTime createdAt;

  NotificationModel({
    this.id,
    this.message,
    this.subject,
    this.createdAt
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  String getTime() {
    if (createdAt == null) {
      return "";
    }
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(createdAt) + " " + DateFormat(DateFormat.HOUR_MINUTE).format(createdAt);
  }
}