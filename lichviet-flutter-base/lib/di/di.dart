import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/api/api_config.dart';
import 'package:lichviet_flutter_base/di/apis_module.dart';
import 'package:lichviet_flutter_base/di/channel_module.dart';
import 'package:lichviet_flutter_base/di/cubit_module.dart';
import 'package:lichviet_flutter_base/di/local_module.dart';
import 'package:lichviet_flutter_base/di/native_module.dart';
import 'package:lichviet_flutter_base/di/network_module.dart';
import 'package:lichviet_flutter_base/di/remote_module.dart';
import 'package:lichviet_flutter_base/di/repository_module.dart';
import 'package:lichviet_flutter_base/di/usecase_module.dart';

Future<void> setupDi(ApiConfig config) async {
  final getIt = GetIt.I;

  await channelModule(getIt);
  await networkModule(getIt);
  await localModule(getIt);
  await apisModule(getIt, config);
  await repositoryModule(getIt);
  await usecaseModule(getIt);
  await cubitModule(getIt);
  await nativeModule(getIt);
  await remoteModule(getIt);
}
