// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quanly_chucvu_bloc.dart';

abstract class QuanLyChucVuEvent extends Equatable {
  const QuanLyChucVuEvent();

  @override
  List<Object?> get props => [];
}

// chức vụ

class LayChucVuEvent extends QuanLyChucVuEvent {
  String giaPhaId;
  LayChucVuEvent(
    this.giaPhaId,
  );
}

class ThemChucVuEvent extends QuanLyChucVuEvent {
  String chucVu;
  String giaPhaId;
  ThemChucVuEvent(
    this.chucVu,
    this.giaPhaId
  );
}

class CapNhapChucVuEvent extends QuanLyChucVuEvent {
  String id;
  String tenChucVu;
  CapNhapChucVuEvent(
     this.id,
     this.tenChucVu,
  );
}

class XoaChucVuEvent extends QuanLyChucVuEvent {
  String id;
  XoaChucVuEvent(
     this.id,
  );
}
