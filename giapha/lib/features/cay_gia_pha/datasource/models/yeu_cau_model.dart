// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class YeuCau {
  final String id;
  final String noiDung;
  final String trangThai;
  final String idNguoiDuyet;
  final String idNguoiYeuCau;
  final String idNhanh;
  final String giaPha;
  final String thoiGianTao;

  YeuCau(this.id, this.noiDung, this.trangThai, this.idNguoiDuyet,
      this.idNguoiYeuCau, this.idNhanh, this.giaPha, this.thoiGianTao);

  YeuCau copyWith(
      {String? id,
      String? noiDung,
      String? trangThai,
      String? idNguoiDuyet,
      String? idNguoiYeuCau,
      String? idNhanh,
      String? giaPha,
      String? thoiGianTao}) {
    return YeuCau(
        id ?? this.id,
        noiDung ?? this.noiDung,
        trangThai ?? this.trangThai,
        idNguoiDuyet ?? this.idNguoiDuyet,
        idNguoiYeuCau ?? this.idNguoiYeuCau,
        idNhanh ?? this.idNhanh,
        giaPha ?? this.giaPha,
        thoiGianTao ?? this.thoiGianTao);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'noi_dung': noiDung,
      'trang_thai': trangThai,
      'id_nguoi_duyet': idNguoiDuyet,
      'id_nguoi_yeu_cau': idNguoiYeuCau,
      'id_nhanh': idNhanh,
      'gia_pha': giaPha,
      'thoi_gian_tao': thoiGianTao
    };
  }

  factory YeuCau.fromMap(Map<String, dynamic> map) {
    return YeuCau(
        map['id'] as String,
        map['noi_dung'] as String,
        map['trang_thai'] as String,
        map['id_nguoi_duyet'] as String,
        map['id_nguoi_yeu_cau'] as String,
        map['id_nhanh'] as String,
        map['gia_pha'] as String,
        map['thoi_gian_tao'] ?? '' as String);
  }

  String toJson() => json.encode(toMap());

  factory YeuCau.fromJson(String source) =>
      YeuCau.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'YeuCau(id: $id, noiDung: $noiDung, trangThai: $trangThai, idNguoiDuyet: $idNguoiDuyet, idNguoiYeuCau: $idNguoiYeuCau, idNhanh: $idNhanh, giaPha: $giaPha, thoiGianTao: $thoiGianTao)';
  }

  @override
  bool operator ==(covariant YeuCau other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.noiDung == noiDung &&
        other.trangThai == trangThai &&
        other.idNguoiDuyet == idNguoiDuyet &&
        other.idNguoiYeuCau == idNguoiYeuCau &&
        other.idNhanh == idNhanh &&
        other.giaPha == giaPha &&
        other.thoiGianTao == thoiGianTao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        noiDung.hashCode ^
        trangThai.hashCode ^
        idNguoiDuyet.hashCode ^
        idNguoiYeuCau.hashCode ^
        idNhanh.hashCode ^
        giaPha.hashCode ^
        thoiGianTao.hashCode;
  }
}
