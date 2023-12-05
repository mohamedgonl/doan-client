import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:lichviet_flutter_base/core/key_rsa_triplet_provider.dart';
import 'package:lichviet_flutter_base/data/datasource/local/app_local_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/local/config_local_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/local/user_local_datasource.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> localModule(GetIt getIt) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  var path = await getTemporaryDirectory();
  Hive.init(path.path);
  await Hive.openBox(userInfoBoxKey);
  getIt
    ..registerLazySingleton<KeyRsaTripletProvider>(
        () => KeyRsaTripletProvider(sharedPreferences))
    ..registerLazySingleton<AppLocalDatasource>(
        () => AppLocalDatasource(sharedPreferences))
    ..registerLazySingleton<ConfigLocalDatasource>(
        () => ConfigLocalDatasource(sharedPreferences))
    ..registerFactory<UserLocalDatasource>(
        () => UserLocalDatasource(sharedPreferences));
}
