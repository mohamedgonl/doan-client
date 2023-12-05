import 'package:get_it/get_it.dart';
import 'package:giapha/features/chia_se/data/datasources/chia_se_remote_datastorage.dart';
import 'package:giapha/features/chia_se/data/repositories/people_shared_repository_impl.dart';
import 'package:giapha/features/chia_se/domain/repositories/people_shared_repository.dart';
import 'package:giapha/features/chia_se/domain/usecases/create_link_share.dart';
import 'package:giapha/features/chia_se/domain/usecases/get_people_shared.dart';
import 'package:giapha/features/chia_se/domain/usecases/handle_changes.dart';
import 'package:giapha/features/chia_se/domain/usecases/save_everry_changes.dart';
import 'package:giapha/features/chia_se/domain/usecases/search_people.dart';
import 'package:giapha/features/chia_se/domain/usecases/set_general_accession.dart';
import 'package:giapha/features/chia_se/domain/usecases/update_role_shared_people.dart';
import 'package:giapha/features/chia_se/presentation/bloc/chia_se_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_bloc.dart';

Future<void> init(GetIt sl) async {
  //bloc
  sl.registerFactory(() => ChiaSeBloc(sl(), sl(), sl()));
  sl.registerFactory(() => SharedBloc(sl(), sl()));
  sl.registerFactory(() => ChoosedBloc(sl()));
  sl.registerFactory(() => SearchBloc(sl()));
  // usecase
  sl.registerLazySingleton(() => SaveEveryChanges(sl()));
  sl.registerLazySingleton(() => GetPeopleShared(sl()));
  sl.registerLazySingleton(() => CreateLinkShare(sl()));
  sl.registerLazySingleton(() => SearchPeople(sl()));
  sl.registerLazySingleton(() => HandleChanges(sl()));
  sl.registerLazySingleton(() => UpdateRoleSharedPeople(sl()));
    sl.registerLazySingleton(() => SetGeneralAccession(sl()));
  // repository
  sl.registerLazySingleton<PeopleSharedRepository>(
      () => PeopleSharedRepositoryImpl(sl(), sl()));

  // data sources

  // remote
  sl.registerLazySingleton<ChiaSeRemoteDataSource>(
      () => ChiaSeRemoteDataSourceImpl(sl()));
  // local

  // network
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkProvider(sl()));

  // share prefers
  // final sharedPreferences = await SharedPreferences.getInstance();

  // sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => Connectivity());
}
