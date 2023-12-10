part of 'access_bloc.dart';

abstract class AccessState extends Equatable {
  const AccessState();

  @override
  List<Object> get props => [];
}

class AccessFailState extends AccessState {
  String message;

  AccessFailState(this.message);
}

class AccessInitial extends AccessState {}

class SendLoginState extends AccessState {}

class SendRegisterState extends AccessState {}

class LoginSuccessState extends AccessState {}

class RegisterSuccessState extends AccessState {}

class LoginFailState extends AccessFailState {
  LoginFailState(super.message);
}

class RegisterFailState extends AccessFailState {
  RegisterFailState(super.message);
}

class AccessLoadingState extends AccessState {}
