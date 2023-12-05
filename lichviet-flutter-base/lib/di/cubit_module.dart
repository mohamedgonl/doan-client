import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/cubit/singleton_anchored_banner_cubit.dart';
import 'package:lichviet_flutter_base/cubit/cache_version_cubit/cache_version_cubit.dart';
import 'package:lichviet_flutter_base/cubit/global_cubit/app_cubit/app_cubit.dart';
import 'package:lichviet_flutter_base/cubit/init_cubit/init_cubit.dart';
import 'package:lichviet_flutter_base/cubit/lunar_calendar_native/lunar_calendar_native_cubit.dart';
import 'package:lichviet_flutter_base/cubit/user_cubit/user_cubit.dart';

Future<void> cubitModule(GetIt getIt) async {
  getIt
    ..registerLazySingleton<UserCubit>(() => UserCubit(getIt(), getIt()))
    ..registerLazySingleton<CacheVersionCubit>(() => CacheVersionCubit(getIt()))
    ..registerLazySingleton<InitCubit>(() => InitCubit(getIt(), getIt()))
    ..registerLazySingleton<AppCubit>(() => AppCubit(getIt(), getIt()))
    ..registerLazySingleton<LunarCalendarNativeCubit>(
        () => LunarCalendarNativeCubit(getIt()))
    ..registerLazySingleton<SingletonAnchoredBannerCubit>(
        () => SingletonAnchoredBannerCubit());
}
