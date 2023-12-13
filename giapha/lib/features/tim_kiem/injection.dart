import 'package:get_it/get_it.dart';
import 'package:giapha/features/tim_kiem/bloc/tim_kiem_gia_pha/tim_kiem_gia_pha_bloc.dart';
import 'package:giapha/features/tim_kiem/bloc/tim_kiem_thanh_vien/tim_kiem_thanh_vien_bloc.dart';
import 'package:giapha/features/tim_kiem/data/data_gia_pha/tim_kiem_gia_pha_datasource.dart';
import 'package:giapha/features/tim_kiem/data/data_thanh_vien/tim_kiem_thanh_vien_datasource.dart';

Future<void> init(GetIt getIt) async {
  //bloc
  getIt.registerFactory(() => TimKiemGiaPhaBloc(getIt()));
  getIt.registerFactory(() => TimKiemThanhVienBloc(getIt()));
  // usecase

  // repository

  // data sources

  // remote
  getIt.registerLazySingleton(() => TimKiemGiaPhaDatasource(getIt()));
  getIt.registerLazySingleton(
      () => TimKiemThanhVienDatasource(getIt()));
  // local
}
