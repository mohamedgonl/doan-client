import 'package:get_it/get_it.dart';
import 'package:giapha/features/ghep_gia_pha/data/datasources/ghep_gia_pha_remote_datasource.dart';
import 'package:giapha/features/ghep_gia_pha/presentation/bloc/ghep_gia_pha_bloc.dart';

Future<void> init(GetIt sl) async {
  //bloc
  sl.registerFactory(() => GhepGiaPhaBloc(sl(), sl()));
  // usecase

  // repository

  // data sources

  // remote
  sl.registerLazySingleton(() => GhepGiaPhaRemoteDataSourceImpl());
  // local
}
