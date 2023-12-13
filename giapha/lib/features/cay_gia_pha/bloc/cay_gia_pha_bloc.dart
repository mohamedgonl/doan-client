import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_datasource.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_local_datasource.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_model.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:dio/dio.dart';
import 'package:giapha/features/cay_gia_pha/datasource/models/yeu_cau_model.dart';
import 'package:giapha/features/tim_kiem/data/data_thanh_vien/tim_kiem_thanh_vien_datasource.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

part 'cay_gia_pha_event.dart';
part 'cay_gia_pha_state.dart';

class CayGiaPhaBloc extends Bloc<CayGiaPhaEvent, CayGiaPhaState> {
  final CayGiaPhaDatasource _cayGiaPhaDatasource;
  final CayGiaPhaLocalDataSource _cayGiaPhaLocalDataSource;
  final TimKiemThanhVienDatasource _timKiemThanhVienDatasource;

  late CayGiaPhaModel cayGiaPhaModel;

  CayGiaPhaBloc(this._cayGiaPhaDatasource, this._cayGiaPhaLocalDataSource,
      this._timKiemThanhVienDatasource)
      : super(CayGiaPhaInitial()) {
    on<CayGiaPhaEvent>((event, emit) async {
      if (event is GetTreeGenealogy) {
        try {
          emit(CayGiaPhaLoading());
          final result =
              await _cayGiaPhaDatasource.getTreeGenealogy(event.idGiaPha);
          final res = (result.fold((l) => GetCayGiaPhaError((l as ServerException).error),
              (r) => GetCayGiaPhaSuccess(r)));
          if (res is GetCayGiaPhaSuccess) {
            cayGiaPhaModel = CayGiaPhaModel(res.listMember);
          }
          emit.call(res);
        } catch (e) {
          if (e is NetworkIssueException) {
            emit(const GetCayGiaPhaError(
                'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
          } else if (e is ServerException) {
            emit(GetCayGiaPhaError(
                (e.error as DioError).message.replaceAll('Exception: ', '')));
          } else {
            emit(const GetCayGiaPhaError(''));
          }
        }
      }
      //  else if (event is LayDanhSachNguoiMat) {
      //   try {
      //     emit(GetDanhSachNguoiMatLoading());
      //     var result;
      //     var res;
      //     if (event.isTabTuDuong) {
      //       result = await _cayGiaPhaDatasource.getDanhSachNguoiMat(
      //           event.idGiaPha,
      //           textSearch: event.textSearch);
      //       res = (result.fold((l) => GetDanhSachNguoiMatError(l.message),
      //           (r) => GetDanhSachNguoiMatSuccess(r)));
      //     } else {
      //       result = await _timKiemThanhVienDatasource.timKiemThanhVienTheoText(
      //           "",
      //           idGiaPha: event.idGiaPha,
      //           die: event.textSearch);
      //       res = GetDanhSachNguoiMatSuccess(result);
      //     }

      //     emit.call(res);
      //   } catch (e) {
      //     if (e is NetworkIssueException) {
      //       emit(const GetDanhSachNguoiMatError(
      //           'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
      //     } else if (e is ServerException) {
      //       emit(GetDanhSachNguoiMatError(
      //           (e.error as DioError).message.replaceAll('Exception: ', '')));
      //     } else {
      //       emit(const GetDanhSachNguoiMatError(''));
      //     }
      //   }
      // }
       else if (event is XoaThanhVienEvent) {
        // final result = await _cayGiaPhaDatasource.xoaThanhVien(event.memberId);
        // final fin = result.fold(
        //     (l) => XoaThanhVienError(), (r) => XoaThanhVienSuccess());
        // emit(fin);
      } else if (event is LayCacYeuCauGhepGiaPhaEvent) {
        // try {
        //   final result = await _cayGiaPhaDatasource.layYeuCauGhepGiaPha();
        //   final fin = result.fold((l) => LayCacYeuCauGhepGiaPhaError(),
        //       (r) => LayCacYeuCauGhepGiaPhaSuccess(r));
        //   emit(fin);
        // } catch (e) {
        //   if (e is NetworkIssueException) {
        //     emit(const GetCayGiaPhaError(
        //         'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
        //   } else if (e is ServerException) {
        //     emit(GetCayGiaPhaError(
        //         (e.error as DioError).message.replaceAll('Exception: ', '')));
        //   } else {
        //     emit(const GetCayGiaPhaError(''));
        //   }
        // }
      } else if (event is SaveLocalCayGiaPha) {
        _cayGiaPhaLocalDataSource.cacheCayGiaPha(event.cayGiaPhaCache,
            indexStep: event.indexStep);
      } else if (event is GetLocalCayGiaPha) {
        try {
          final result = await _cayGiaPhaLocalDataSource
              .layCacheCayGiaPha(event.indexStep);
          emit(GetCayGiaPhaSuccess(result));
        } catch (e) {
          if (e is NetworkIssueException) {
            emit(const GetCayGiaPhaError(
                'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
          } else if (e is ServerException) {
            emit(GetCayGiaPhaError(
                (e.error as DioError).message.replaceAll('Exception: ', '')));
          } else {
            emit(const GetCayGiaPhaError(''));
          }
        }
      } else if (event is ClearCacheEvent) {
        _cayGiaPhaLocalDataSource.clearCacheGiaPha();
      } 
      // else if (event is LuuNhieuAction) {
      //   try {
      //     emit(XuLyNhieuActionLoading());
      //     final result = await _cayGiaPhaDatasource.luuNhieuAction(
      //       event.listCreated,
      //       event.listIdDelete,
      //       event.listUpdated,
      //     );
      //     final res = (result.fold(
      //         (l) => XuLyNhieuActionError(
      //             (l as ServerException).error, event.viTri),
      //         (r) => XuLyNhieuActionSuccess(event.viTri)));

      //     emit.call(res);
      //   } catch (e) {
      //     if (e is NetworkIssueException) {
      //       emit(XuLyNhieuActionError(
      //           'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!',
      //           event.viTri));
      //     } else if (e is ServerException) {
      //       emit(XuLyNhieuActionError(
      //           (e.error as DioError).message.replaceAll('Exception: ', ''),
      //           event.viTri));
      //     } else {
      //       emit(XuLyNhieuActionError('', event.viTri));
      //     }
      //   }
      // }
    });
  }

  Future<List<List<Member>>> getListMemberLocal(int step) async {
    final result = await _cayGiaPhaLocalDataSource.layCacheCayGiaPha(step);
    return result;
  }

  void saveLocalSearch(String userId, List<String> listTextSearch) {
    _cayGiaPhaLocalDataSource.saveLocalSearch(userId, listTextSearch);
  }

  List<String> getLocalSaveSearch(String userId) {
    return _cayGiaPhaLocalDataSource.getLocalSaveSearch(userId);
  }
}
