import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/domain/usecases/create_link_share.dart';
import 'package:giapha/features/chia_se/domain/usecases/get_people_shared.dart';
import 'package:giapha/features/chia_se/domain/usecases/save_everry_changes.dart';
import 'package:giapha/features/chia_se/domain/usecases/search_people.dart';
import 'package:giapha/features/chia_se/domain/usecases/set_general_accession.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_bloc.dart';

part 'chia_se_event.dart';
part 'chia_se_state.dart';

class ChiaSeBloc extends Bloc<ChiaSeEvent, ChiaSeState> {
  final SaveEveryChanges saveEveryChanges;
  final CreateLinkShare createLinkShare;
  final SetGeneralAccession setGeneralAccession;
  List<Person> choosedPeople = [];
  List<Person> sharedPeople = [];

  ChiaSeBloc(
      this.saveEveryChanges, this.createLinkShare, this.setGeneralAccession)
      : super(ChiaSeInitial()) {
    on<ChiaSeEvent>((event, emit) {});
    on<CreateLinkEvent>((event, emit) async {
      final response = await createLinkShare(event.option);
      final fin = response.fold(
          (l) => Error(message: 'Error'), (r) => CreateLinkState(r));
      emit(fin);
    });

    on<GeneralAccessionEvent>((event, emit) {
      final response = setGeneralAccession(event.personRole);
      emit(GeneralAccessionState(response));
    });
  }
}
