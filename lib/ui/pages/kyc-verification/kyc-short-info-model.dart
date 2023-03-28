import 'package:json_annotation/json_annotation.dart';

part 'kyc-short-info-model.g.dart';

@JsonSerializable()
class KYCShortInfoModel {
  int id;
  int documentTypeId;
  bool isApproved;
  bool isRejected;
  int userKycId;

  @JsonKey(defaultValue: "")
  String rejectReason;


  KYCShortInfoModel({
    this.id,
    this.documentTypeId,
    this.isApproved,
    this.isRejected,
    this.rejectReason,
    this.userKycId,
  });

  factory KYCShortInfoModel.fromJson(Map<String, dynamic> json) =>
      _$KYCShortInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$KYCShortInfoModelToJson(this);
}