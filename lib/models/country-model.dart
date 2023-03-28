import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/ui/common-widgets/selection-page.dart';

part 'country-model.g.dart';

@JsonSerializable()
class CountryModel implements SelectionModel {
  int id;
  String niceName;
  String iso;
  int phoneCode;
  
  String get value => niceName;

  CountryModel({
    this.id,
    this.niceName,
    this.iso,
    this.phoneCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}