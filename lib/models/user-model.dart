import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/models/bank-model.dart';

part 'user-model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(defaultValue: "")
  String phone;

  @JsonKey(defaultValue: "")
  String email;

  @JsonKey(defaultValue: "")
  String firstName;

  @JsonKey(defaultValue: "")
  String secondName;
  int countryId;

  @JsonKey(defaultValue: "")
  String city;

  @JsonKey(defaultValue: "")
  String address;

  @JsonKey(defaultValue: "")
  String birthDate;

  @JsonKey(defaultValue: "")
  String refNumber;

  @JsonKey(fromJson: _bankDetailsFromJson)
  List<BankModel> bankDetails;

  int serviceLevel;
  String approvedAt;
  String rejectedAt;
  String rejectedReason;

  UserModel({
    this.phone = "",
    this.email = "",
    this.firstName = "",
    this.secondName = "",
    this.countryId,
    this.city = "",
    this.address = "",
    this.birthDate = "",
    this.refNumber = "",
    this.serviceLevel,
    this.approvedAt = "",
    this.rejectedAt = "",
    this.rejectedReason = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static List<BankModel> _bankDetailsFromJson(Map<String, dynamic> data) {
    List<BankModel> bankDetails = new List<BankModel>();
    for (var key in data.keys) {
      var details = data[key];
      try {
        for (int i = 0; i < details.length; i++) {
          bankDetails.add(BankModel.fromJson(details[i]));
        }
      } catch (error) {}
    }
    return bankDetails;
  }

  bool isDocsApproved() {
    if (rejectedAt != null && rejectedAt.isNotEmpty && rejectedReason != null && rejectedReason.isNotEmpty) {
      return false;
    }
    return approvedAt != null && approvedAt.isNotEmpty;
  }

  String getName() {
    return (firstName + " " + secondName).trim();
  }
}
