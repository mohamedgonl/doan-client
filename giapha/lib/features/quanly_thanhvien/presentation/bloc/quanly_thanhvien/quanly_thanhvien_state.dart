// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quanly_thanhvien_bloc.dart';

abstract class QuanLyThanhVienState extends Equatable {
  const QuanLyThanhVienState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class QuanLyThanhVienLoading extends QuanLyThanhVienState {}

class QuanLyThanhVienInitial extends QuanLyThanhVienState {}

class ThemThanhVienError extends QuanLyThanhVienState {
  final String? msg;
  const ThemThanhVienError({this.msg});
}

class ThemThanhVienSuccess extends QuanLyThanhVienState {
  final MemberInfo newMemberInfo;

  const ThemThanhVienSuccess(this.newMemberInfo);
}

class LayThanhVienError extends QuanLyThanhVienState {
  final String? msg;
  const LayThanhVienError({this.msg});
}



class LayThanhVienSuccess extends QuanLyThanhVienState {
  final Member member;

  const LayThanhVienSuccess(this.member);
}

class SuaThanhVienError extends QuanLyThanhVienState {
  final String? msg;
  const SuaThanhVienError({this.msg});
}

class SuaThanhVienSuccess extends QuanLyThanhVienState {
  final MemberInfo editedMemberInfo;

  const SuaThanhVienSuccess(this.editedMemberInfo);
}

class MaLichVietHopLe extends QuanLyThanhVienState {
  final LichVietMemberModel lichVietMember;
  const MaLichVietHopLe(
    this.lichVietMember,
  );
}

class MaLichVietLoading extends QuanLyThanhVienState {}

class MaLichVietDaCoTrongGiaPha extends QuanLyThanhVienState {}

class MaLichVietKhongHopLe extends QuanLyThanhVienState {
  final String msg;
  const MaLichVietKhongHopLe(this.msg);
}

class MaLichVietEmpty extends QuanLyThanhVienState {}
