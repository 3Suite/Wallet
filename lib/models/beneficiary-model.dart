import 'package:json_annotation/json_annotation.dart';

part 'beneficiary-model.g.dart';

@JsonSerializable()
class BeneficiaryModel {
  @JsonKey(defaultValue: 0)
  int id;

  @JsonKey(defaultValue: "")
  String iban;

  @JsonKey(defaultValue: "")
  String firstName;
  int countryId;

  @JsonKey(defaultValue: "")
  String swiftCode;

  @JsonKey(defaultValue: false)
  bool favourite;

  BeneficiaryModel({
    this.id,
    this.iban,
    this.firstName,
    this.countryId,
    this.swiftCode,
    this.favourite,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) => _$BeneficiaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$BeneficiaryModelToJson(this);
}
