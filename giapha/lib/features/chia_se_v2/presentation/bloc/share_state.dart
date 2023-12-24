part of 'share_bloc.dart';

abstract class ShareState extends Equatable {
  const ShareState();

  @override
  List<Object?> get props => [];
}

class TimKiemUserInitial extends ShareState {}

class TimKiemUserLoading extends ShareState {}

class TimKiemUserSuccess extends ShareState {
  final List<UserInfo> listUser;
  const TimKiemUserSuccess(this.listUser);
}

class TimKiemUserError extends ShareState {
  final String msg;
  const TimKiemUserError(this.msg);
}
