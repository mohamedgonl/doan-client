import 'package:lichviet_flutter_base/domain/usecases/api_config_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/app_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/cache_version_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/key_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/lunar_calendar_native_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/premium_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/user_usecase.dart';
import 'package:get_it/get_it.dart';

Future<void> usecaseModule(GetIt getIt) async {
  getIt
    ..registerFactory<UserUsecase>(() => UserUsecase(getIt()))
    ..registerFactory<KeyUsecases>(() => KeyUsecases(getIt()))
    ..registerFactory<ApiConfigUsecases>(() => ApiConfigUsecases(getIt()))
    ..registerLazySingleton<CacheVersionUseCase>(
        () => CacheVersionUseCase(getIt()))
    ..registerFactory<LunarCalendarNativeUseCase>(
        () => LunarCalendarNativeUseCase(getIt()))
    ..registerFactory<AppUseCase>(() => AppUseCase(getIt()))
    ..registerFactory<PremiumUsecase>(() => PremiumUsecase(getIt(), getIt()));
}
