

import 'package:get_it/get_it.dart';
import 'package:giapha/features/access/data/datasources/access_remote_datasource.dart';
import 'package:giapha/features/access/presentation/bloc/access_bloc.dart';

Future<void> init(GetIt sl) async {
  //bloc
  sl.registerFactory(() => AccessBloc(sl()));
  // remote
  sl.registerLazySingleton(
      () => AccessRemoteDataSource());
}
