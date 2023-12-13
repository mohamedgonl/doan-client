import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:giapha/features/danhsach_giapha/domain/usecases/lay_danhsach_giapha.dart';
import 'package:dio/dio.dart';
import 'package:giapha/features/danhsach_giapha/domain/usecases/xoa_gia_pha.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

part 'danhsach_giapha_event.dart';
part 'danhsach_giapha_state.dart';

// const String SERVER_FAILURE_MESSAGE = 'Server Failure';
// const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class DanhsachGiaphaBloc
    extends Bloc<DanhsachGiaphaEvent, DanhsachGiaphaState> {
  final LayDanhSachGiaPha layDanhSachGiaPha;
  final XoaGiaPha xoaGiaPha;
  DanhsachGiaphaBloc(this.layDanhSachGiaPha, this.xoaGiaPha)
      : super(DanhsachGiaphaInitial()) {
    on<LayDanhSachGiaPhaEvent>(_layDanhSachGiaPha);
    on<XoaGiaPhaEvent>(_xoaGiaPha);
  }

  Future<void> _layDanhSachGiaPha(
      LayDanhSachGiaPhaEvent event, Emitter<DanhsachGiaphaState> emit) async {
    try {
      emit(Loading());
      final response = await layDanhSachGiaPha(NoParams());
      final fin = response.fold(
          (l) => const LayDanhSachError(
              message: "'Lỗi hệ thống hoặc kết nối mạng. Vui lòng thử lại.'"),
          (r) => Loaded(r));
      emit(fin);
    } catch (e) {
      if (e is NetworkIssueException) {
        emit(const LayDanhSachError(
            message: "Không có kết nối mạng. Vui lòng kiểm tra & thử lại!"));
      } else if (e is ServerException) {
        emit(LayDanhSachError(
            message:
                (e.error as DioError).message.replaceAll('Exception: ', '')));
      } else {
        emit(const LayDanhSachError(message: ''));
      }
    }
  }

  Future<void> _xoaGiaPha(
      XoaGiaPhaEvent event, Emitter<DanhsachGiaphaState> emit) async {
    try {
      emit(Loading());
      final response = await xoaGiaPha(event.idGiaPha);
      final fin = response.fold(
          (l) => const LayDanhSachError(
              message: 'Lỗi hệ thống hoặc kết nối mạng. Vui lòng thử lại.'),
          (r) => XoaGiaPhaSuccess());
      emit(fin);
    } catch (e) {
      if (e is NetworkIssueException) {
        emit(const LayDanhSachError(
            message: 'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
      } else if (e is ServerException) {
        emit(LayDanhSachError(
            message:
                (e.error as DioError).message.replaceAll('Exception: ', '')));
      } else {
        emit(const LayDanhSachError(message: ''));
      }
    }
  }
}
