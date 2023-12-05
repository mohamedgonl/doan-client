import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnSearchEvent extends SearchEvent {
  final String search_string;
  final String idGiaPha;
  OnSearchEvent(this.search_string, this.idGiaPha);
}
