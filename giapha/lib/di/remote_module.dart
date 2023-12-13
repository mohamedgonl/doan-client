import 'package:get_it/get_it.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_datasource.dart';

Future<void> remoteModule(GetIt getIt) async {
  getIt
    .registerLazySingleton<CayGiaPhaDatasource>(
        () => CayGiaPhaDatasource());
   
}
