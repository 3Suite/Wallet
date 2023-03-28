import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/ui/pages/dashboard/transactions-filter.dart';

part 'pagination-model.g.dart';

@JsonSerializable(includeIfNull: false)
class PaginationModel {
  int page = 0;
  int size = 20;
  int type = 0;
  @JsonKey(toJson: _filterToJson)
  TransactionsFilter filter;
  List<String> sort = ["created_at DESC"];

  PaginationModel({this.page, this.size, this.type, this.filter, this.sort});
  PaginationModel.withFilter({@required this.filter}) {
    page = 0;
    size = 20;
    type = 0;
    sort = ["created_at DESC"];
  }

  PaginationModel.withoutFilter() {
    page = 0;
    size = 20;
    type = 0;
    sort = ["created_at DESC"];
  }

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  static Map<String, dynamic> _filterToJson(TransactionsFilter filter) {
    if (filter == null) {
      return {};
    }
    return filter.toJson();
  }
}
