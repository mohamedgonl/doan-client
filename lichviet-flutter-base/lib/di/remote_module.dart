import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/api_config_remote_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/app_remote_datasouce.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/cache_version_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/premium_remote_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/user_remote_datasource.dart';

Future<void> remoteModule(GetIt getIt) async {
  getIt
    ..registerLazySingleton<ApiConfigRemoteDataSource>(
        () => ApiConfigRemoteDataSourceImpl(
              getIt(),
            ))
    ..registerFactory<AppRemoteDataSource>(
        () => AppRemoteDataSourceImpl(getIt()))
    ..registerFactory<PremiumRemoteDataSource>(
        () => PremiumRemoteDataSourceImpl(getIt()))
    ..registerFactory<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(getIt(), getIt()))
    ..registerFactory<CacheVersionRemoteDataSource>(
        () => CacheVersionDataSourceIplm(getIt()));
}
