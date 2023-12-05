import 'dart:convert';

import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DanhSachGiaPhaResponseModel {
  final bool status;
  final List<dynamic> created;
  final List<dynamic> shared;

  DanhSachGiaPhaResponseModel({
    required this.status,
    required this.created,
    required this.shared,
  });

  factory DanhSachGiaPhaResponseModel.fromJson(Map<String, dynamic> json) {

    return DanhSachGiaPhaResponseModel(
      status: json['status'],
      created: json['data']['created'],
      shared: json['data']['shared'],
    );
  }
}
