part of 'access_bloc.dart';

abstract class AccessEvent extends Equatable {
  const AccessEvent();

  @override
  List<Object> get props => [];
}

class SendLoginEvent extends AccessEvent {
  UserInfo userInfo;

  SendLoginEvent(this.userInfo);
}

class SendRegisterEvent extends AccessEvent {}
