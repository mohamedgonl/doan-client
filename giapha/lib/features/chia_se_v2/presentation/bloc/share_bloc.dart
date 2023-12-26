import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/features/access/data/models/user_info.dart';
import 'package:giapha/features/chia_se_v2/datasource/share_remote_datasource.dart';
import 'package:dio/dio.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

part 'share_event.dart';
part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final ShareRemoteDataSource _shareDatasource;
  ShareBloc(this._shareDatasource) : super(TimKiemUserInitial()) {
    on<ShareEvent>((event, emit) async {
      if (event is TimKiemUser) {
        try {
          emit(TimKiemUserLoading());
          final result =
              await _shareDatasource.timKiemUserTheoText(event.keySearch);

          emit.call(TimKiemUserSuccess(result));
        } catch (e) {
          if (e is NetworkIssueException) {
            emit(const TimKiemUserError(
                'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
          } else if (e is ServerException) {
            emit(TimKiemUserError(
                (e.error as DioError).message.replaceAll('Exception: ', '')));
          } else {
            emit(const TimKiemUserError(''));
          }
        }
      }

      if (event is ShareToUser) {
        try {
          emit(const ShareToUserLoading());
          final result = await _shareDatasource.share(
              event.listUser, event.quyenTruyCap, event.familyId);
          if (result) {
            emit.call(const ShareToUserSuccess());
          } else {
            emit(const ShareToUserError());
          }
        } catch (e) {
          emit(const ShareToUserError());
        }
      }
    });
  }
}
