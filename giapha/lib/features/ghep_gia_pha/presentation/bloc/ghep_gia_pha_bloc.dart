import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/features/cay_gia_pha/bloc/cay_gia_pha_bloc.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_datasource.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/danhsach_giapha/data/datasources/danhsach_giapha_remote_data_source.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:giapha/features/ghep_gia_pha/data/datasources/ghep_gia_pha_remote_datasource.dart';

part 'ghep_gia_pha_event.dart';
part 'ghep_gia_pha_state.dart';

class GhepGiaPhaBloc extends Bloc<GhepGiaPhaEvent, GhepGiaPhaState> {
  final GhepGiaPhaRemoteDataSourceImpl ghepGiaPhaRemoteDataSourceImpl;
  final CayGiaPhaDatasource cayGiaPhaDatasource;

  GhepGiaPhaBloc(this.ghepGiaPhaRemoteDataSourceImpl, this.cayGiaPhaDatasource)
      : super(GhepGiaPhaInitial()) {
    on<GhepGiaPhaEvent>((event, emit) async {
      if (event is LayDanhSachGiaPhaDaTaoEvent) {
        final res =
            await ghepGiaPhaRemoteDataSourceImpl.layDanhSachGiaPhaDaTao();
        emit(res.fold((l) => LayDanhSachGiaPhaDaTaoError(),
            (r) => LayDanhSachGiaPhaDaTaoSuccess(r)));
      }

      if (event is LayDanhSachNhanhSrcEvent) {
        final res = await cayGiaPhaDatasource.getTreeGenealogy(event.giaPhaId);
        final fin = res.fold((l) => LayDanhSachNhanhSrcError(), (r) {
          List<Member> danhsach = [];
          for (var x1 in r) {
            for (var x2 in x1) {
              danhsach.add(x2);
            }
          }
          return LayDanhSachNhanhSrcSuccess(danhsach);
        });
        emit(fin);
      }

      if (event is LayDanhSachNhanhDesEvent) {
        final res = await cayGiaPhaDatasource.getTreeGenealogy(event.giaPhaId);
        final fin = res.fold((l) => LayDanhSachNhanhDesError(), (r) {
          List<Member> danhsach = [];
          for (var x1 in r) {
            for (var x2 in x1) {
              danhsach.add(x2);
            }
          }
          return LayDanhSachNhanhDesSuccess(danhsach);
        });
        emit(fin);
      }

      if (event is GhepPreviewEvent) {
        final res = await ghepGiaPhaRemoteDataSourceImpl.ghepPreview(
            event.nhanhSrcChoosed, event.nhanhDesChoosed, event.giaPhaId);
        final fin = res.fold((l) => GhepPreviewFail(message: l.message),
            (r) => GhepPreviewReady(cayGiaPha: r));

        emit(fin);
      }

      if (event is YeuCauGhepGiaPhaEvent) {
        final res = await ghepGiaPhaRemoteDataSourceImpl.ghepGiaPha(
            event.nhanhSrcChoosed, event.nhanhDesChoosed, event.giaPhaId);
        final fin = res.fold((l) => GhepFail(message: l.message),
            (r) => GhepSuccess());

        emit(fin);
      }
    });
  }
}
