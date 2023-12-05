part of 'chia_se_bloc.dart';

abstract class ChiaSeEvent extends Equatable {
  const ChiaSeEvent();

  @override
  List<Object> get props => [];
}

class GeneralAccessionEvent extends ChiaSeEvent {
  final PersonRole personRole;

  GeneralAccessionEvent(this.personRole);
}

class CreateLinkEvent extends ChiaSeEvent {
  final String option;

  CreateLinkEvent(this.option);
}
