import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giapha/features/them_gia_pha/domain/entities/them_or_gia_pha_entity.dart';
import 'package:giapha/features/them_gia_pha/domain/usecases/them_or_sua_gia_pha.dart';
import 'package:lichviet_flutter_base/core/core.dart';

part 'them_gia_pha_event.dart';
part 'them_gia_pha_state.dart';

class ThemGiaPhaBloc extends Bloc<ThemGiaPhaEvent, ThemGiaPhaState> {
  final ThemOrSuaGiaPha themOrSuaGiaPha;
  ThemGiaPhaBloc(this.themOrSuaGiaPha) : super(ThemGiaPhaInitial()) {
    // on<ThemGiaPhaEvent>((event, emit) {});
    on<SaveThemOrSuaGiaPhaEvent>((event, emit) async {
      emit(ThemGiaPhaLoading());
      if (event.giaPhaId.isNullOrEmpty) {
        final res = await themOrSuaGiaPha(event.data);
        final fin = res.fold(
            (l) => ThemGiaPhaError(msg: l), (r) => ThemGiaPhaSuccess());
        emit(fin);
      } else {
        ThemOrSuaGiaPhaEntity dataEntity = event.data;
        dataEntity.giaPhaId = event.giaPhaId;
        final res = await themOrSuaGiaPha(dataEntity);
        final fin = res.fold(
            (l) => SuaGiaPhaError(msg: l), (r) => SuaGiaPhaSuccess());
        emit(fin);
      }
    });
    on<ThemGiaPhaInitEvent>((event, emit) {
      emit(ThemGiaPhaInitial());
    });
  }
}
