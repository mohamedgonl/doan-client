import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_datasource.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_local_datasource.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_model.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:dio/dio.dart';
import 'package:giapha/features/cay_gia_pha/presentation/cay_gia_pha_screen.dart';
import 'package:lichviet_flutter_base/core/core.dart';

part 'xu_ly_nhieu_action_event.dart';
part 'xu_ly_nhieu_action_state.dart';

class XuLyNhieuActionBloc extends Bloc<XuLyAction, XuLyActionState> {
  final CayGiaPhaDatasource _cayGiaPhaDatasource;

  late CayGiaPhaModel cayGiaPhaModel;

  XuLyNhieuActionBloc(this._cayGiaPhaDatasource) : super(XuLyNhieuInitial()) {
    on<XuLyAction>((event, emit) async {
      if (event is LuuNhieuAction) {
        try {
          emit(XuLyNhieuActionLoading());
          final result = await _cayGiaPhaDatasource.luuNhieuAction(
            event.listCreated,
            event.listIdDelete,
            event.listUpdated,
          );
          final res = (result.fold(
              (l) => XuLyNhieuActionError(
                  (l as ServerException).error, event.viTri),
              (r) => XuLyNhieuActionSuccess(event.viTri)));

          emit.call(res);
        } catch (e) {
          if (e is NetworkIssueException) {
            emit(XuLyNhieuActionError(
                'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!',
                event.viTri));
          } else if (e is ServerException) {
            emit(XuLyNhieuActionError(
                (e.error as DioError).message.replaceAll('Exception: ', ''),
                event.viTri));
          } else {
            emit(XuLyNhieuActionError('', event.viTri));
          }
        }
      }
    });
  }
}
