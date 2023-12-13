import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/features/danhsach_giapha/data/datasources/danhsach_giapha_local_data_source.dart';
import 'package:giapha/features/danhsach_giapha/data/datasources/danhsach_giapha_remote_data_source.dart';
import 'package:giapha/features/danhsach_giapha/data/repositories/danhsach_giapha_repository_impl.dart';
import 'package:giapha/features/danhsach_giapha/domain/repositories/danhsach_giapha_repository.dart';
import 'package:giapha/features/danhsach_giapha/domain/usecases/lay_danhsach_giapha.dart';
import 'package:giapha/features/danhsach_giapha/domain/usecases/xoa_gia_pha.dart';
import 'package:giapha/features/danhsach_giapha/presentation/bloc/danhsach_giapha_bloc.dart';
import 'package:http/http.dart' as http;
// import 'package:lichviet_flutter_base/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init(GetIt sl) async {
  //bloc
  sl.registerFactory(() => DanhsachGiaphaBloc(sl(), sl()));
  // usecase
  sl.registerLazySingleton(() => LayDanhSachGiaPha(sl()));
  sl.registerLazySingleton(() => XoaGiaPha(sl()));
  // repository
  sl.registerLazySingleton<DanhSachGiaPhaRepository>(
      () => DanhSachGiaPhaRepositoryImpl(sl(), sl()));

  // data sources

  // remote
  sl.registerLazySingleton<DanhSachGiaPhaRemoteDataSource>(
      () => DanhSachGiaPhaRemoteDataSourceImpl());
  // local
  sl.registerLazySingleton<DanhSachGiaPhaLocalDataSource>(
      () => DanhSachGiaPhaLocalDataSourceImpl(sharedPreferences: sl()));

  // network
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkProvider(sl()));

  // share prefers
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
