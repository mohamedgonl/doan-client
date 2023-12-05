import 'dart:convert';

import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ThemGiaPhaResponse {
  final bool status;
  final Object data;

  ThemGiaPhaResponse({required this.status, required this.data});

  factory ThemGiaPhaResponse.fromJson(Map<String, dynamic> json) {
    return ThemGiaPhaResponse(
      status: json['status'],
      data: json['data'],
    );
  }
}
