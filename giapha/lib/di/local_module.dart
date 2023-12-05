import 'package:get_it/get_it.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> localModule(GetIt getIt) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<CayGiaPhaLocalDataSource>(
      () => CayGiaPhaLocalDataSourceImpl(sharedPreferences: sharedPreferences));
}
