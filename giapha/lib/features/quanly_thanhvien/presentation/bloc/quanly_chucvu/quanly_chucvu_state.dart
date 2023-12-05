// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quanly_chucvu_bloc.dart';

abstract class QuanLyChucVuState extends Equatable {
  final List<ChucVuModel>? danhsachChucVu;
  const QuanLyChucVuState({this.danhsachChucVu});

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class QuanLyChucVuInitial extends QuanLyChucVuState {}

class ThemChucVuError extends QuanLyChucVuState {}

class ThemChucVuSuccess extends QuanLyChucVuState {
  ChucVuModel chucVu;
  ThemChucVuSuccess(this.chucVu);
}

class LayChucVuError extends QuanLyChucVuState {}

class LayChucVuSuccess extends QuanLyChucVuState {
  final List<ChucVuModel> danhsachChucVu;

  LayChucVuSuccess(this.danhsachChucVu);
}

class CapNhapChucVuSuccess extends QuanLyChucVuState {
  String chucVuId;
  String tenChucVu;
  CapNhapChucVuSuccess(
    this.chucVuId,
    this.tenChucVu,
  );
}

class CapNhapChucVuError extends QuanLyChucVuState {}

class XoaChucVuSuccess extends QuanLyChucVuState {
  String chucVuId;
  XoaChucVuSuccess(
    this.chucVuId,
  );
}
