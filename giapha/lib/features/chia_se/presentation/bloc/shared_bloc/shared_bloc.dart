// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/chia_se/domain/usecases/get_people_shared.dart';
import 'package:giapha/features/chia_se/domain/usecases/handle_changes.dart';
import 'package:giapha/features/chia_se/domain/usecases/update_role_shared_people.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_event.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  GetPeopleShared getPeopleShared;
  UpdateRoleSharedPeople updateRoleSharedPeople;

  SharedBloc(this.getPeopleShared, this.updateRoleSharedPeople)
      : super(SharedInitState()) {
    on<GetPeopleSharedEvent>((event, emit) async {
      final response = await getPeopleShared(event.giaPhaId);
      final fin = response.fold((l) => Error(message: 'Error'),
          (r) => r.isEmpty ? Empty() : GetPeopleSharedState(r));
      emit(fin);
    });
    on<UpdateRoleSharedPeopleEvent>((event, emit) {
      final response = updateRoleSharedPeople(
          ChangesParams(person: event.person, option: event.option));
      if (response.isEmpty) {
        emit(Empty());
      } else {
        emit(UpdateRoleSharedPeopleState(response));
        emit(GetPeopleSharedState(response));
      }
    });
  }
}
