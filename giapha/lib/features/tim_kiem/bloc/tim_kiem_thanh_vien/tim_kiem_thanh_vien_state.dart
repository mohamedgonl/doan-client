part of 'tim_kiem_thanh_vien_bloc.dart';

abstract class TimKiemThanhVienState extends Equatable {
  const TimKiemThanhVienState();

  @override
  List<Object?> get props => [];
}

class TimKiemThanhVienInitial extends TimKiemThanhVienState {}

class TimKiemThanhVienLoading extends TimKiemThanhVienState {}

class TimKiemThanhVienSuccess extends TimKiemThanhVienState {
  final List<UserInfo> listMember;
  const TimKiemThanhVienSuccess(this.listMember);
}

class TimKiemThanhVienError extends TimKiemThanhVienState {
  final String msg;
  const TimKiemThanhVienError(this.msg);
}
