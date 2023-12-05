import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giapha/features/chia_se/domain/usecases/handle_changes.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_event.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_state.dart';

class ChoosedBloc extends Bloc<ChooseEvent, ChoosedState> {
  final HandleChanges handleChanges;
  ChoosedBloc(this.handleChanges) : super(ChoosedInitState()) {
    on<AddPeopleToPickedListEvent>((event, emit) async {
      final response =
          handleChanges(ChangesParams(person: event.person, option: "ADD"));

      final fin = response.fold(
          (l) => Error(message: l), (r) => ChoosedPeopleChangeState(r));
      emit(fin);
    });
    on<RemovePeopleOfPickedListEvent>((event, emit) async {
      final response =
          handleChanges(ChangesParams(person: event.person, option: "REMOVE"));

      final fin = response.fold(
          (l) => Error(message: l), (r) => ChoosedPeopleChangeState(r));
      emit(fin);
    });
    on<ChangeRolePickedListEvent>((event, emit) {
      handleChanges(ChangesParams(
          option: "PICKED_ROLE_CHANGE",
          role: event.role,
          branch: event.branch));
    });

    on<DestroySingleTonEvent>((event, emit) {
      handleChanges(ChangesParams(option: "DESTROY_SINGLETON"));
    });
  }
}
