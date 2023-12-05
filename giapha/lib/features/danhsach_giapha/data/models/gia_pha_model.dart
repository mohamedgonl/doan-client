import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';

class GiaPhaModel extends GiaPha {
  GiaPhaModel(
      {required String id,
      required String tenGiaPha,
      required String tenNhanh,
      required String diaChi,
      required String moTa,
      required String idNguoiTao,
      required DateTime thoiGianTao,
      required String tenNguoiTao,
      required String soDoi,
      required String soThanhVien,
      required username,
      required fullName,
      required email,
      required phone})
      : super(
            diaChi: diaChi,
            id: id,
            tenGiaPha: tenGiaPha,
            tenNhanh: tenNhanh,
            moTa: moTa,
            idNguoiTao: idNguoiTao,
            thoiGianTao: thoiGianTao,
            tenNguoiTao: tenNguoiTao,
            soDoi: soDoi,
            soThanhVien: soThanhVien);

  factory GiaPhaModel.fromJSON(Map<String, dynamic> json) {
    return GiaPhaModel(
        id: json['id'] ?? "",
        tenGiaPha: json['ten_gia_pha'] ?? "",
        tenNhanh: json['ten_nhanh'] ?? "",
        diaChi: json['dia_chi'] ?? "",
        moTa: json['mo_ta'] ?? "",
        idNguoiTao: json['id_nguoi_tao'] ?? "",
        thoiGianTao: DateTime.parse(json['thoi_gian_tao']),
        username: json['username'] ?? "",
        fullName: json['full_name'] ?? "",
        email: json['email'] ?? "",
        phone: json['phone'] ?? "",
        tenNguoiTao: json['full_name'] ?? "",
        soDoi: json['so_doi'] ?? "",
        soThanhVien: json['so_thanh_vien'] ?? "");
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'ten_gia_pha': tenGiaPha,
      'ten_nhanh': tenNhanh,
      'dia_chi': diaChi,
      'mo_ta': moTa,
      'id_nguoi_tao': idNguoiTao,
      'thoi_gian_tao': thoiGianTao.toString(),
      'full_name': tenNguoiTao,
      'so_doi': soDoi,
      'so_thanh_vien': soThanhVien
    };
  }
}
