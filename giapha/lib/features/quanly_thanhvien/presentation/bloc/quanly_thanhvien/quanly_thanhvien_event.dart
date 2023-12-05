// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quanly_thanhvien_bloc.dart';

abstract class QuanLyThanhVienEvent extends Equatable {
  const QuanLyThanhVienEvent();

  @override
  List<Object?> get props => [];
}

// thành viên

class ValidateByLVCodeEvent extends QuanLyThanhVienEvent {
  final String LVCode;
  const ValidateByLVCodeEvent(this.LVCode);
}

class ThemThanhVienEvent extends QuanLyThanhVienEvent {
  final MemberInfo memberInfo;
  final bool saveCallApi;
  const ThemThanhVienEvent(
    this.memberInfo, {
    this.saveCallApi = true,
  });
}

class LayThanhVienEvent extends QuanLyThanhVienEvent {
  final String memberId;
  const LayThanhVienEvent(this.memberId);
}

class XacThucMaLichVietEvent extends QuanLyThanhVienEvent {
  final String maLichViet;
  final String giaPhaId;

  const XacThucMaLichVietEvent(
    this.maLichViet,
    this.giaPhaId,
  );
}

class SuaThanhVienEvent extends QuanLyThanhVienEvent {
  final MemberInfo memberInfo;
  final bool saveCallApi;
  const SuaThanhVienEvent(
    this.memberInfo, {
    this.saveCallApi = true,
  });
}
