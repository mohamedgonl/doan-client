import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/tim_kiem/data/data_thanh_vien/tim_kiem_thanh_vien_datasource.dart';
import 'package:dio/dio.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

part 'tim_kiem_thanh_vien_event.dart';
part 'tim_kiem_thanh_vien_state.dart';

class TimKiemThanhVienBloc
    extends Bloc<TimKiemThanhVienEvent, TimKiemThanhVienState> {
  final TimKiemThanhVienDatasource _timKiemThanhVienDatasource;
  TimKiemThanhVienBloc(this._timKiemThanhVienDatasource)
      : super(TimKiemThanhVienInitial()) {
    on<TimKiemThanhVienEvent>((event, emit) async {
      if (event is TimKiemThanhVienTheoText) {
        try {
          emit(TimKiemThanhVienLoading());
          final result =
              await _timKiemThanhVienDatasource.timKiemThanhVienTheoText(
            event.keySearch,
            idGiaPha: event.idGiaPha,
            gioiTinh: event.gioiTinh,
            idChucVu: event.idChucVu,
            year: event.year,
          );

          emit.call(TimKiemThanhVienSuccess(result));
        } catch (e) {
          if (e is NetworkIssueException) {
            emit(const TimKiemThanhVienError(
                'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
          } else if (e is ServerException) {
            emit(TimKiemThanhVienError(
                (e.error as DioError).message.replaceAll('Exception: ', '')));
          } else {
            emit(const TimKiemThanhVienError(''));
          }
        }
      }
    });
  }

  void saveLocalSearch(String userId, List<String> listTextSearch) {
    _timKiemThanhVienDatasource.saveLocalSearch(userId, listTextSearch);
  }

  List<String> getLocalSaveSearch(String userId) {
    return _timKiemThanhVienDatasource.getLocalSaveSearch(userId);
  }
}
