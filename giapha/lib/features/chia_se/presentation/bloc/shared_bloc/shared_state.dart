import 'package:equatable/equatable.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';

abstract class SharedState extends Equatable {
  SharedState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class SharedInitState extends SharedState {}

class GetPeopleSharedState extends SharedState {
  final List<Person> people;

  GetPeopleSharedState(this.people);

  List<Person> get getPeople => [...people];
  @override
  List<Person> get props => [...people];
}

class UpdateRoleSharedPeopleState extends SharedState {
  final List<Person> people;

  // @override
  // List<Person> get props => [...people];
  List<Person> get getPeople => [...people];
  UpdateRoleSharedPeopleState(this.people);
}

class Empty extends SharedState {}

class Error extends SharedState {
  final String message;

  Error({required this.message}) : super();
}
