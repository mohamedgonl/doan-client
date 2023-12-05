import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/data/repositories/api_config_repository_impl.dart';
import 'package:lichviet_flutter_base/data/repositories/app_repository_impl.dart';
import 'package:lichviet_flutter_base/data/repositories/cache_version_repository_impl.dart';
import 'package:lichviet_flutter_base/data/repositories/key_rsa_triplet_impl.dart';
import 'package:lichviet_flutter_base/data/repositories/lunar_calendar_native_impl.dart';
import 'package:lichviet_flutter_base/data/repositories/premium_repository_impl.dart';
import 'package:lichviet_flutter_base/data/repositories/user_repository_impl.dart';
import 'package:lichviet_flutter_base/domain/repositories/api_config_repository.dart';
import 'package:lichviet_flutter_base/domain/repositories/app_repository.dart';
import 'package:lichviet_flutter_base/domain/repositories/cache_version_repository.dart';
import 'package:lichviet_flutter_base/domain/repositories/key_rsa_triplet_repository.dart';
import 'package:lichviet_flutter_base/domain/repositories/lunar_calendar_native_repository.dart';
import 'package:lichviet_flutter_base/domain/repositories/premium_repository.dart';
import 'package:lichviet_flutter_base/domain/repositories/user_repository.dart';

Future<void> repositoryModule(GetIt getIt) async {
  getIt
    ..registerLazySingleton<ApiConfigRepository>(
        () => ApiConfigRepositoryImpl(getIt()))
    ..registerFactory<PremiumRepository>(() => PremiumRepositoryImpl(getIt()))
    ..registerFactory<UserRepository>(() => UserRepositoryImpl(
          getIt(),
          getIt(),
          getIt(),
        ))
    ..registerFactory<AppRepository>(
        () => AppRepositoryImpl(getIt(), getIt(), getIt()))
    ..registerFactory<KeyRsaTripletRepository>(
        () => KeyRsaTripletRepositoryImpl(
              getIt(),
            ))
    ..registerFactory<LunarCalendarNativeRepository>(
        () => LunarCalendarFromNativeImpl(getIt()))
    ..registerFactory<CacheVersionRepository>(
        () => CacheVersionRepositoryImpl(getIt()));
}
