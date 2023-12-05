import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:giapha/features/tim_kiem/data/data_gia_pha/tim_kiem_gia_pha_datasource.dart';
import 'package:dio/dio.dart';
import 'package:lichviet_flutter_base/core/core.dart';

part 'tim_kiem_gia_pha_event.dart';
part 'tim_kiem_gia_pha_state.dart';

class TimKiemGiaPhaBloc extends Bloc<TimKiemGiaPhaEvent, TimKiemGiaPhaState> {
  final TimKiemGiaPhaDatasource _timKiemGiaPhaDatasource;
  TimKiemGiaPhaBloc(this._timKiemGiaPhaDatasource)
      : super(TimKiemGiaPhaInitial()) {
    on<TimKiemGiaPhaEvent>((event, emit) async {
      if (event is TimKiemGiaPhaTheoText) {
        try {
          emit(TimKiemGiaPhaLoading());
          final result = await _timKiemGiaPhaDatasource
              .timKiemGiaPhaTheoText(event.keySearch);

          emit.call(TimKiemGiaPhaSuccess(result));
        } catch (e) {
          if (e is NetworkIssueException) {
            emit(const TimKiemGiaPhaError(
                'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
          } else if (e is ServerException) {
            emit(TimKiemGiaPhaError(
                (e.error as DioError).message.replaceAll('Exception: ', '')));
          } else {
            emit(const TimKiemGiaPhaError(''));
          }
        }
      }
    });
  }

  void saveLocalSearch(String userId, List<String> listTextSearch) {
    _timKiemGiaPhaDatasource.saveLocalSearch(userId, listTextSearch);
  }

  List<String> getLocalSaveSearch(String userId) {
    return _timKiemGiaPhaDatasource.getLocalSaveSearch(userId);
  }
}
