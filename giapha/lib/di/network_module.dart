import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lichviet_flutter_base/core/core.dart';

Future<void> networkModule(GetIt getIt) async {
  getIt.registerLazySingleton<NetworkProvider>(
      () => NetworkProvider(Connectivity()));
}
