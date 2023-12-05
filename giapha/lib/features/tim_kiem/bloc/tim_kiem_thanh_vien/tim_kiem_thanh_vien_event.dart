part of 'tim_kiem_thanh_vien_bloc.dart';

abstract class TimKiemThanhVienEvent extends Equatable {
  const TimKiemThanhVienEvent();

  @override
  List<Object?> get props => [];
}

class TimKiemThanhVienTheoText extends TimKiemThanhVienEvent {
  final String keySearch;
  final String? idChucVu;
  final String? gioiTinh;
  final int? year;
  final String? idGiaPha;
  const TimKiemThanhVienTheoText(
    this.keySearch, {
    this.idGiaPha,
    this.gioiTinh,
    this.idChucVu,
    this.year,
  });
}
