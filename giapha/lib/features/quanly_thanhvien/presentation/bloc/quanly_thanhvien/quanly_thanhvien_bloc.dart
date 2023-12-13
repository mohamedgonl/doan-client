import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/quanly_thanhvien/data/datasources/quanly_thanhvien_remote_datasource.dart';
// import 'package:lichviet_flutter_base/core/core.dart';
// import 'package:lichviet_flutter_base/domain/usecases/usercases.dart';
import 'package:dio/dio.dart';

part 'quanly_thanhvien_event.dart';
part 'quanly_thanhvien_state.dart';

class QuanLyThanhVienBloc
    extends Bloc<QuanLyThanhVienEvent, QuanLyThanhVienState> {
  final QuanLyThanhVienDataSource _quanLyThanhVienDataSource;

  QuanLyThanhVienBloc(this._quanLyThanhVienDataSource)
      : super(QuanLyThanhVienInitial()) {
    on<QuanLyThanhVienEvent>((event, emit) async {
      if (event is ThemThanhVienEvent) {
        try {
          if (event.saveCallApi) {
            emit(QuanLyThanhVienLoading());
            String? avatar;
            if (event.memberInfo.avatar != null &&
                event.memberInfo.avatar!.isNotEmpty) {
              // avatar = await _userUsecase.uploadFile(
              //     'jpeg', event.memberInfo.avatar!, 'user', 'avatar');
              event.memberInfo.avatar = avatar;
            }

            final result = await _quanLyThanhVienDataSource
                .themThanhVien(event.memberInfo);
            final fin = result.fold((l) => const ThemThanhVienError(),
                (r) => ThemThanhVienSuccess(r));
            emit(fin);
          } else {
            String? avatar;
            if (event.memberInfo.avatar != null &&
                event.memberInfo.avatar!.isNotEmpty) {
              // avatar = await _userUsecase.uploadFile(
              //     'jpeg', event.memberInfo.avatar!, 'user', 'avatar');
              event.memberInfo.avatar = avatar;
            }

            emit(ThemThanhVienSuccess(event.memberInfo));
          }
        } catch (e) {
          if (e is NetworkIssueException) {
            emit(const ThemThanhVienError(
                msg: 'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
          } else if (e is ServerException) {
            emit(ThemThanhVienError(
                msg: (e.error as DioError)
                    .message
                    .replaceAll('Exception: ', '')));
          } else {
            emit(const ThemThanhVienError(msg: ''));
          }
        }
      }

      if (event is SuaThanhVienEvent) {
        try {
          String? avatar;
          if (event.saveCallApi) {
            emit(QuanLyThanhVienLoading());
            String? avatar;
            if (event.memberInfo.avatar != null &&
                event.memberInfo.avatar!.isNotEmpty) {
              // avatar = await _userUsecase.uploadFile(
              //     'jpeg', event.memberInfo.avatar!, 'user', 'avatar');
              event.memberInfo.avatar = avatar;
            }

            final result =
                await _quanLyThanhVienDataSource.suaThanhVien(event.memberInfo);
            final fin = result.fold((l) => const SuaThanhVienError(),
                (r) => SuaThanhVienSuccess(event.memberInfo));
            emit(fin);
          } else {
            if (event.memberInfo.avatar != null &&
                event.memberInfo.avatar!.isNotEmpty) {
              // avatar = await _userUsecase.uploadFile(
              //     'jpeg', event.memberInfo.avatar!, 'user', 'avatar');
              event.memberInfo.avatar = avatar;
            }
            emit(SuaThanhVienSuccess(event.memberInfo));
          }
        } catch (e) {
          if (e is NetworkIssueException) {
            emit(const SuaThanhVienError(
                msg: 'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
          } else if (e is ServerException) {
            emit(SuaThanhVienError(
                msg: (e.error as DioError)
                    .message
                    .replaceAll('Exception: ', '')));
          } else {
            emit(const SuaThanhVienError(msg: ''));
          }
        }
      }
      if (event is LayThanhVienEvent) {
        emit(QuanLyThanhVienLoading());
        try {
          final result =
              await _quanLyThanhVienDataSource.layThanhVien(event.memberId);
          final fin = result.fold(
              (l) => const LayThanhVienError(), (r) => LayThanhVienSuccess(r));
          emit(fin);
        } catch (e) {
          print(e);
          if (e is NetworkIssueException) {
            emit(const SuaThanhVienError(
                msg: 'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
          } else if (e is ServerException) {
            emit(LayThanhVienError(
                msg: (e.error as DioError)
                    .message
                    .replaceAll('Exception: ', '')));
          } else {
            emit(const LayThanhVienError(msg: ''));
          }
        }
      }
    });
  }
}
