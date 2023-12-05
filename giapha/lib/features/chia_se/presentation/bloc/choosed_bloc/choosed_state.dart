import 'package:equatable/equatable.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';

abstract class ChoosedState extends Equatable {
  ChoosedState();
  @override
  List<Object> get props => [identityHashCode(this)];
}

class ChoosedPeopleChangeState extends ChoosedState {
  final List<Person> choosedPeople;
  ChoosedPeopleChangeState(this.choosedPeople);
}

class ChoosedInitState extends ChoosedState {
  
}

// class RoleChangesState extends ChoosedState {
//   final 
// }

class Empty extends ChoosedState {}

class Error extends ChoosedState {
  final String message;

  Error({required this.message}) : super();
}
