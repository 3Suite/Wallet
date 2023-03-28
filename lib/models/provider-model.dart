import 'package:json_annotation/json_annotation.dart';

part 'provider-model.g.dart';

enum ProviderTypesEnum { card, type, bank }

@JsonSerializable()
class ProviderModel {
  int id;

  @JsonKey(defaultValue: "")
  String name;

  @JsonKey(defaultValue: 0)
  double fee;

  @JsonKey(defaultValue: "")
  String terms;

  @JsonKey(defaultValue: "CARD")
  String type;

  ProviderModel({
    this.id,
    this.name,
    this.fee,
    this.terms,
    this.type,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) => _$ProviderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderModelToJson(this);

  bool isBank() {
    return type.toLowerCase() == "bank";
  }
}
