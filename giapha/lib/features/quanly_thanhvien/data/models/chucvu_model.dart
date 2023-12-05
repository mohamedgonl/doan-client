// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChucVuModel {
  String id;
  String tenChucVu;
  // String? nguoiTao;
  // String? userId;
  // String? giaPhaId;
  ChucVuModel({
    required this.id,
    required this.tenChucVu,
  });

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'id': id,
      'ten_chuc_vu': tenChucVu,
    };
  }

  factory ChucVuModel.fromJSON(Map<String, dynamic> map) {
    return ChucVuModel(
      id: map['id'] as String,
      tenChucVu: map['ten_chuc_vu'] as String,
    );
  }
}
