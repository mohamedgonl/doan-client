// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class GiaPha extends Equatable {
  final String id;
  final String tenGiaPha;
  final String diaChi;
  final String moTa;
  final String idNguoiTao;
  final DateTime thoiGianTao;
  final String tenNguoiTao;
   String soDoi;
   String soThanhVien;

  GiaPha({
    required this.id,
    required this.tenGiaPha,
    required this.diaChi,
    required this.moTa,
    required this.idNguoiTao,
    required this.thoiGianTao,
    required this.tenNguoiTao,
    required this.soDoi,
    required this.soThanhVien
  });

  @override
  List<Object?> get props =>
      [id, tenGiaPha, diaChi, moTa, idNguoiTao, thoiGianTao, tenNguoiTao, soDoi, soThanhVien];
}
