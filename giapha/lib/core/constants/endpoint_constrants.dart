class EndPointConstrants {
  static const getTreeGenealogy = "/api/ft/genealogy/get/tree";
  static const layDanhSachGiaPha = "/api/ft/genealogy/get/list";
  static const layDanhSachNguoiMAt = "/api/ft/genealogy/get/die";
  static const taoLinkChiaSe = "/api/ft/share/create";
  static const capNhapQuyen = "/api/ft/share/update";
  static const layUsersDuocChiaSe = "/api/ft/share/get";
  static const themQuyenBangMa = "/api/ft/share/user";
  static const searchNguoiDung = "";
  static const taoGiaPha = "/api/ft/genealogy/create";
  static const xoaGiaPha = "/api/ft/genealogy/delete";
  static const suaGiaPha = "/api/ft/genealogy/update";

  static const layThanhVien = "/api/ft/member/get/detail";
  static const themThanhVien = "/api/ft/member/create";
  static const xoaThanhVien = "/api/ft/member/delete";
  static const suaThanhVien = "/api/ft/member/update";

  static const layYeuCauGhepNhanh = "/api/ft/request/get";
  static const suaNhieuAction = "/api/ft/member/edits";

  // Chức vụ
  static const layChucVu = "/api/ft/position/get";
  static const themChucVu = "/api/ft/position/create";
  static const capNhapChucVu = "/api/ft/position/update";
  static const xoaChucVu = "/api/ft/position/delete";

  // ghép gia phả
  static const layYeuCauGhepGiaPha = "/api/ft/request/get";
  static const taoYeuCauGhepGiaPha = "/api/ft/request/create";
  static const chapNhanYeuCauGhepGiaPha = "/api/ft/request/approved";
  static const tuChoiYeuCauGhepGiaPha = "/api/ft/request/deny";

  // tim kiem
  static const timKiemThanhVien = '/api/ft/member/find';
  static const timKiemGiaPha = "/api/ft/genealogy/find";

  // xác thực mã lịch việt
  static const xacThucMaLichViet = '/api/ft/user/check';

  static const domain = "http://192.168.0.1:3000/v1/api"; // 'http://192.168.1.92:8080';
}
