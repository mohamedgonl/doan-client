part of 'share_bloc.dart';

abstract class ShareState extends Equatable {
  const ShareState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class TimKiemUserInitial extends ShareState {}

class TimKiemUserLoading extends ShareState {}

class TimKiemUserSuccess extends ShareState {
  final List<UserInfo> listUser;
  const TimKiemUserSuccess(this.listUser);
}

class ShareToUserSuccess extends ShareState {
  const ShareToUserSuccess();
}

class ShareToUserError extends ShareState {
  const ShareToUserError();
}

class ShareToUserLoading extends ShareState {
  const ShareToUserLoading();
}
class TimKiemUserError extends ShareState {
  final String msg;
  const TimKiemUserError(this.msg);
}
