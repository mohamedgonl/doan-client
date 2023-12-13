import 'package:get_it/get_it.dart';
import 'package:giapha/features/them_gia_pha/data/datasources/remote_datasource.dart';
import 'package:giapha/features/them_gia_pha/data/repositories/them_gia_pha_repository_impl.dart';
import 'package:giapha/features/them_gia_pha/domain/repositories/them_or_sua_gia_pha_repository.dart';
import 'package:giapha/features/them_gia_pha/domain/usecases/them_or_sua_gia_pha.dart';
import 'package:giapha/features/them_gia_pha/presentation/bloc/them_gia_pha_bloc.dart';

Future<void> init(GetIt sl) async {
  //bloc
  sl.registerFactory(() => ThemGiaPhaBloc(sl()));
  // usecase
  sl.registerLazySingleton(() => ThemOrSuaGiaPha(sl()));
  // repository
  sl.registerLazySingleton<ThemOrSuaGiaPhaRepository>(
      () => ThemOrSuaGiaPhaRepositoryImpl(sl()));

  // data sources

  // remote
  sl.registerLazySingleton<ThemGiaPhaRemoteDataSource>(
      () => ThemGiaPhaRemoteDataSourceImpl());
  // local

  // network
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkProvider(sl()));

  // share prefers
}
