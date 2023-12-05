part of 'chia_se_bloc.dart';

abstract class ChiaSeState extends Equatable {
  ChiaSeState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class ChiaSeInitial extends ChiaSeState {}

class CreateLinkState extends ChiaSeState {
  final String link;
  CreateLinkState(this.link);
}

class GeneralAccessionState extends ChiaSeState {
  final PersonRole personRole;
  GeneralAccessionState(this.personRole);
}

class Empty extends ChiaSeState {}

class Error extends ChiaSeState {
  final String message;

  Error({required this.message}) : super();
}
