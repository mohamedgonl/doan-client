import 'package:equatable/equatable.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';

abstract class SearchState extends Equatable {
  SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitState extends SearchState {}

class OnSearchState extends SearchState {
  final List<Person> people;
  OnSearchState(this.people);
}

class Empty extends SearchState {}

class Error extends SearchState {
  final String message;

  Error({required this.message}) : super();
}
