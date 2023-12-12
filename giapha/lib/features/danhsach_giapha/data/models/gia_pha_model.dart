import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';

class GiaPhaModel extends GiaPha {
  GiaPhaModel({
    required String id,
    required String tenGiaPha,
    required String diaChi,
    required String moTa,
    required String idNguoiTao,
    required DateTime thoiGianTao,
    required String tenNguoiTao,
    required String soDoi,
    required String soThanhVien,
  }) : super(
            diaChi: diaChi,
            id: id,
            tenGiaPha: tenGiaPha,
            moTa: moTa,
            idNguoiTao: idNguoiTao,
            thoiGianTao: thoiGianTao,
            tenNguoiTao: tenNguoiTao,
            soDoi: soDoi,
            soThanhVien: soThanhVien);

  factory GiaPhaModel.fromJSON(Map<String, dynamic> json) {
    return GiaPhaModel(
        id: json['_id'] ?? "",
        tenGiaPha: json['name'] ?? "",
        diaChi: json['address']["display_address"] ?? "",
        moTa: json['description'] ?? "",
        idNguoiTao: json['createBy']["_id"] ?? "",
        thoiGianTao: DateTime.parse(json['createdAt']),
        tenNguoiTao: json['createBy']["name"] ?? "",
        soDoi: json['genLength'].toString(),
        soThanhVien: json['memCount'].toString());
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'ten_gia_pha': tenGiaPha,
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
