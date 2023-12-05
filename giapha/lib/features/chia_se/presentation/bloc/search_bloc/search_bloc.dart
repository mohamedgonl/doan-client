import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giapha/features/chia_se/domain/usecases/search_people.dart';
import 'package:giapha/features/chia_se/presentation/bloc/search_bloc/search_event.dart';
import 'package:giapha/features/chia_se/presentation/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchPeople searchPeople;
  SearchBloc(this.searchPeople) : super(SearchInitState()) {
    on<OnSearchEvent>((event, emit) async {
      if (event.search_string.isNotEmpty) {
        final response = await searchPeople(event.search_string, event.idGiaPha);
        final fin = response.fold(
            (l) => Error(message: 'Error'), (r) => OnSearchState(r));
        emit(fin);
      }
    });
  }
}
