import 'package:equatable/equatable.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';

abstract class ChooseEvent extends Equatable {
  const ChooseEvent();

  @override
  List<Object> get props => [];
}

class AddPeopleToPickedListEvent extends ChooseEvent {
  final Person person;
  const AddPeopleToPickedListEvent(this.person);
}

class RemovePeopleOfPickedListEvent extends ChooseEvent {
  final Person person;
  const RemovePeopleOfPickedListEvent(this.person);
}

class ChangeRolePickedListEvent extends ChooseEvent {
  final PersonRole role;
  final String branch;
  const ChangeRolePickedListEvent(this.role, this.branch);
}

class DestroySingleTonEvent extends ChooseEvent {
  
}